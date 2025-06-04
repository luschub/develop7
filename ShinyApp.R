library(shiny)
library(readxl)
library(dplyr)

ui <- fluidPage(
  titlePanel("Dynamische Darstellung der Zinssätze"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selectedDate", "Wählen Sie Datum:", choices = NULL),
      sliderInput("selectedLaufzeit", "Wählen Sie die Zeitspanne (Jahre):", 
                  min = 1, max = 250, value = c(1, 250), step = 1)
    ),
    mainPanel(
      plotOutput("yieldPlot")
    )
  )
)

server <- function(input, output, session) {
  # Lese die Excel-Datei und konvertiere die Spalten in die passenden Typen
  data <- reactive({
    file_path <- "/Users/lutzschubbert/dev7/develop7/yields_long_2025-06-03.xlsx"
    df <- read_excel(file_path)
    df <- df %>%
      mutate(
        Datum = as.Date(Datum),          # Stelle sicher, dass Datum ein Date-Objekt ist
        Laufzeit = as.numeric(Laufzeit), # Konvertiere Laufzeit in numerisch
        yields = as.numeric(yields)      # Konvertiere yields in numerisch
      )
    df
  })
  
  # Aktualisiere die Datumsauswahl
  observe({
    req(data())
    dates <- sort(unique(data()$Datum))
    updateSelectInput(session, "selectedDate", choices = dates, selected = dates[1])
  })
  
  output$yieldPlot <- renderPlot({
    req(input$selectedDate, input$selectedLaufzeit)
    
    # Filtere den Datensatz anhand des gewählten Datums und der gewählten Laufzeitspanne
    df_sub <- data() %>%
      filter(Datum == as.Date(input$selectedDate),
             Laufzeit >= input$selectedLaufzeit[1],
             Laufzeit <= input$selectedLaufzeit[2])
    
    if(nrow(df_sub) == 0) {
      plot.new()
      title(main = paste("Keine Daten verfügbar für", input$selectedDate, 
                          "in der Laufzeitspanne", paste(input$selectedLaufzeit, collapse = " - ")))
    } else {
      plot(df_sub$Laufzeit, df_sub$yields, type = "l", lwd = 2,
           xlab = "Laufzeit (Jahre)", ylab = "Zinssatz",
           main = paste("Laufzeitprofil am", input$selectedDate))
    }
  })
}

shinyApp(ui, server)