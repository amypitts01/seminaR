library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("State Exploration"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
    
      h6("Choose a Region to focus on"), 
      # Input: Drop down menu for plot ----
      selectInput(inputId = "region1", label = strong("Region"),
                  choices = c("Northeast" = "Northeast",
                              "South" = "South",
                              "North Central" = "North Central",
                              "West" = "West"),
                  selected = "Northeast"
      ),
      h6("Choose a type of data to be displayed on the y-axis"), 
      selectInput(inputId = "info", label = strong("Type of Data"),
                  choices = c("Income" = 5,
                              "Life.Exp" = 7,
                              "Murder" = 8,
                              "Area" = 11),
                              selected = "Income"
      )),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Plot ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Plot of the State Data by Region ----
  # with requested region and data type
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    state.df <- data.frame(state.abb,state.region,state.division,state.x77)

    subset <- state.df[state.region == input$region1,]
    
    info_st <- input$info
    
    plot( droplevels(subset$state.abb), subset[,as.numeric(info_st)], 
          xlab="State",
          main = "Data about States by Region")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
