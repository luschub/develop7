library(shiny)
library(ggplot2)
library(dplyr)
library(readr)

# Funktion zur Svensson-Berechnung
svensson <- function(T, beta0, beta1, beta2, beta3, tau1, tau2) {
  term1 <- beta1 * (1 - exp(-T/tau1)) / (T/tau1)
  term2 <- beta2 * ((1 - exp(-T/tau1)) / (T/tau1) - exp(-T/tau1))
  term3 <- beta3 * ((1 - exp(-T/tau2)) / (T/tau2) - exp(-T/tau2))
  beta0 + term1 + term2 + term3
}

# Automatisch einzulesende Datei (passen Sie den Dateinamen an, falls erforderlich)
data_file <- "C:/Users/SchubbertLu/Downloads/Svensson_2025-06-03.csv"

ui <- fluidPage(
  titlePanel("Berechnung des Basiszinssatzes nach IDW"),
  sidebarLayout(
    sidebarPanel(
      h4("Datenquelle:"),
      tags$p("CSV-Datei automatisch geladen aus:"),
      tags$p(data_file),
      dateRangeInput("dateRange", "Wählen Sie den Zeitraum",
                     start = Sys.Date() - 30, end = Sys.Date()),
      sliderInput("maturity", "Maximale Laufzeit (Jahre)", min = 1, max = 250, value = 250),
      actionButton("compute", "Berechnen")
    ),
    mainPanel(
      plotOutput("yieldPlot"),
      verbatimTextOutput("basiszinsOutput")
    )
  )
)

server <- function(input, output, session) {
  # CSV-Daten automatisch einlesen: Erwartet werden Spalten: Datum, B0, B1, B2, B3, T1, T2
  parameters <- reactive({
    req(file.exists(data_file))
    df <- read_csv(data_file, show_col_types = FALSE)
    # Datum konvertieren falls nötig
    if("Datum" %in% colnames(df)) {
      df$Datum <- as.Date(df$Datum)
    }
    # Verwenden Sie parse_number um nur die numerischen Bestandteile zu extrahieren:
    df <- df %>% 
      mutate(across(c(B0, B1, B2, B3, T1, T2), ~ readr::parse_number(.)))
    df
  })
  
  # Filtert die Parameter-Daten nach dem ausgewählten Zeitraum
  filteredParameters <- reactive({
    req(parameters())
    df <- parameters()
    req(input$dateRange)
    df %>% filter(Datum >= input$dateRange[1], Datum <= input$dateRange[2])
  })
  
  # Berechnung der Zinssätze bei Klick auf "Berechnen"
  computeResult <- eventReactive(input$compute, {
    params <- filteredParameters()
    # Mittelwert der Parameter (B0, B1, B2, B3, T1, T2) über den ausgewählten Zeitraum
    params_avg <- params %>% 
      summarise(across(c(B0, B1, B2, B3, T1, T2), mean, na.rm = TRUE))
    
    maturities <- 1:input$maturity
    
    # Für jede Laufzeit wird anhand der gemittelten Parameter der Zinssatz berechnet.
    yieldMatrix <- sapply(maturities, function(T) {
      svensson(T,
               params_avg$B0,
               params_avg$B1,
               params_avg$B2,
               params_avg$B3,
               params_avg$T1,
               params_avg$T2)
    })
    avgYieldCont <- yieldMatrix
    
    # Umrechnung in diskrete Renditen: r_diskret = exp(r_stetig) - 1
    avgYieldDisc <- exp(avgYieldCont) - 1
    
    data.frame(
      Maturity = maturities,
      ContinuousYield = avgYieldCont,
      DiscreteYield = avgYieldDisc
    )
  })
  
  # Plot der diskreten Renditekurve
  output$yieldPlot <- renderPlot({
    req(computeResult())
    df <- computeResult()
    ggplot(df, aes(x = Maturity, y = DiscreteYield)) +
      geom_line(color = "blue", size = 1) +
      labs(title = "Diskrete Renditekurve",
           x = "Laufzeit (Jahre)",
           y = "Diskrete Rendite (in Dezimalform)") +
      theme_minimal()
  })
  
  # Ausgabe des Basiszinssatzes (durchschnittlicher diskreter Zinssatz)
  output$basiszinsOutput <- renderPrint({
    req(computeResult())
    df <- computeResult()
    basiszinssatz <- mean(df$DiscreteYield, na.rm = TRUE)
    cat("Laufzeitunabhängiger Basiszinssatz (diskret, durchschnittlich):",
        round(basiszinssatz*100, 2), "%")
  })
}

shinyApp(ui = ui, server = server)