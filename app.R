library(shiny)

# Define UI for the interactive epidemic modeling application
ui <- fluidPage(
  titlePanel("Epidemic Modeling: SI, SIS, and SIR Models"),
  sidebarLayout(
    sidebarPanel(
      selectInput("model", "Choose a Model:", choices = c("SI", "SIS", "SIR")),
      sliderInput("beta", "Transmission Rate (β):", min = 0.00001, max = 0.001, value = 0.00015),
      sliderInput("gamma", "Recovery Rate (γ) (Only for SIS & SIR):", min = 0.01, max = 0.2, value = 0.04)
    ),
    mainPanel(
      plotOutput("epidemicPlot"),
      verbatimTextOutput("modelExplanation")
    )
  )
)

server <- function(input, output) {
  output$epidemicPlot <- renderPlot({
    S <- 400
    I <- 1
    R <- 0
    a <- input$beta
    g <- input$gamma
    day <- 1
    Shist <- c()
    Ihist <- c()
    Rhist <- c()
    
    while (day < 400) {
      Shist[day] <- S
      Ihist[day] <- I
      if (input$model == "SIR") {
        Rhist[day] <- R
      }
      
      deltaS <- -a * S * I
      deltaI <- a * S * I 
      
      if (input$model == "SIS" || input$model == "SIR") {
        deltaI <- a * S * I - g * I
      }
      
      if (input$model == "SIR") {
        deltaR <- g * I
        R <- R + deltaR
      }
      
      S <- S + deltaS
      I <- I + deltaI
      
      S <- max(S, 0)
      I <- max(I, 0)
      if (input$model == "SIR") {
        R <- max(R, 0)
      }
      
      day <- day + 1
    }
    
    plot(Shist / (S + I + R), type = "l", col = "black", ylim = c(0, 1), ylab = "Proportion", xlab = "Time")
    lines(Ihist / (S + I + R), col = "red")
    if (input$model == "SIR") {
      lines(Rhist / (S + I + R), col = "blue")
    }
    
    legend("topright", legend = c("Susceptible", "Infected", if (input$model == "SIR") "Recovered"), 
           col = c("black", "red", "blue"), lty = 1)
  })
  
  output$modelExplanation <- renderText({
    if (input$model == "SI") {
      return("The SI model assumes once individuals are infected, they remain infected indefinitely.\n\nEquations:\n\n dS/dt = -βSI\n dI/dt = βSI")
    } else if (input$model == "SIS") {
      return("The SIS model assumes individuals can recover but gain no immunity, returning to the susceptible state.\n\nEquations:\n\n dS/dt = -βSI + γI\n dI/dt = βSI - γI")
    } else {
      return("The SIR model assumes recovered individuals gain immunity, moving into the recovered state.\n\nEquations:\n\n dS/dt = -βSI\n dI/dt = βSI - γI\n dR/dt = γI")
    }
  })
}

shinyApp(ui = ui, server = server)
