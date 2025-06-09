# filepath: /Users/lutzschubbert/dev7/develop7/shiny_app/ShinyApp.R

# Laden der benötigten Pakete
# - shiny: Für die Erstellung von interaktiven Web-Apps in R
# - readxl: Zum Einlesen von Excel-Dateien
# - dplyr: Für die Datenmanipulation und das Filtern der Daten
library(shiny)
library(readxl)
library(dplyr)

# Definition der Benutzeroberfläche (UI)
# Hier wird auf das sogenannte "Top-Bar-Layout" umgestellt:
# Die Eingabeelemente erscheinen oberhalb des Plots.
ui <- fluidPage(
  # Titel der Shiny-App
  titlePanel("Dynamische Darstellung der Zinssätze"),
  
  # Layout für Eingabefelder oberhalb des Hauptinhalts
  fluidRow(
    column(12,
           # Auswahl mehrerer Daten: selectizeInput mit multiple = TRUE
           # maxItems: Beschränkt die Auswahl auf maximal 5 Einträge
           selectizeInput("selectedDate", "Wählen Sie Datum (max. 5):",
                          choices = NULL, multiple = TRUE, options = list(maxItems = 5)),
           # Slider zur Auswahl der Laufzeitspanne
           sliderInput("selectedLaufzeit", "Wählen Sie die Zeitspanne (Jahre):", 
                       min = 1, max = 250, value = c(1, 250), step = 1)
    )
  ),
  
  # Hauptbereich: Plot-Ausgabe, der die Linien für die ausgewählten Daten zeigt.
  fluidRow(
    column(12,
           plotOutput("yieldPlot")
    )
  )
)

# Definition der Serverlogik
server <- function(input, output, session) {
  
  # Reaktive Funktion zum Einlesen der Excel-Datei
  # Diese Funktion wird automatisch erneut ausgeführt, wenn sich abhängige Werte ändern (z. B. beim ersten Laden)
  data <- reactive({
    # Definiere den Pfad zur Excel-Datei
    file_path <- file.path("yields_long_2025-06-09.xlsx")
    
    # Lese die Excel-Datei ein; read_excel() erkennt meistens automatisch den richtigen Typ
    df <- read_excel(file_path)
    
    # Verwende dplyr::mutate(), um die Datentypen der Spalten sicherzustellen:
    # - Datum: wird als Date-Objekt interpretiert
    # - Laufzeit: in numerischen Wert umgewandelt
    # - yields: wird in numerischen Wert umgewandelt
    df <- df %>%
      mutate(
        Datum = as.Date(Datum),          # Konvertiere die Datumsspalte in ein Date-Objekt
        Laufzeit = as.numeric(Laufzeit), # Sicherstellen, dass die Laufzeit numerisch ist
        yields = as.numeric(yields)      # Sicherstellen, dass die Zinssatzwerte numerisch sind
      )
    df  # Rückgabe des bereinigten DataFrames
  })
  
  # Beobachter (Observer), der die Auswahlmöglichkeiten im selectInput "selectedDate" aktualisiert
  # Sobald die Daten eingelesen wurden, werden alle eindeutigen Datumswerte extrahiert und sortiert.
  observe({
    # Sicherstellen, dass data() existiert und nicht NULL ist
    req(data())
    
    # Extrahiere alle eindeutigen Datumseinträge und sortiere sie aufsteigend
    dates <- sort(unique(data()$Datum))
    
    # Aktualisiere den selectInput, die Choices (Auswahlmöglichkeiten) setzen und 
    # standardmäßig das erste Datum als ausgewählte Option
    updateSelectizeInput(session, "selectedDate", choices = dates,
                         selected = if(length(dates)) dates[1] else NULL)
  })
  
  # Erzeugung der Plot-Ausgabe "yieldPlot"
  output$yieldPlot <- renderPlot({
    # Es wird sichergestellt, dass sowohl ein Datum als auch eine Laufzeitspanne ausgewählt sind,
    # bevor mit der weiteren Verarbeitung fortgefahren wird.
    req(input$selectedDate, input$selectedLaufzeit)
    
    # Definiere ein Farbschema (bis zu 5 Farben)
    colors <- c("red", "blue", "green", "orange", "purple")
    
    # Falls keine Daten für die Auswahl vorhanden sind, einen leeren Plot mit Hinweis erstellen
    if(length(input$selectedDate) == 0){
      plot.new()
      title("Bitte wählen Sie mind. ein Datum aus!")
      return(NULL)
    }
    
    # Erstelle den Basisplot, indem als erstes der Plot für das erste ausgewählte Datum gezeichnet wird.
    # Danach werden weitere Linien hinzugefügt.
    first <- TRUE
    legend_labels <- c()
    
    for(i in seq_along(input$selectedDate)) {
      date_sel <- as.Date(input$selectedDate[i])
      # Filtere den Datensatz für das jeweilige Datum und die gewählte Laufzeitspanne
      df_sub <- data() %>%
        filter(Datum == date_sel,
               Laufzeit >= input$selectedLaufzeit[1],
               Laufzeit <= input$selectedLaufzeit[2])
      
      # Wenn Datensätze vorhanden sind, wird die Linie zum Plot hinzugefügt
      if(nrow(df_sub) > 0) {
        # Beim ersten Plot() wird das Plotfenster initialisiert
        if(first) {
          plot(df_sub$Laufzeit, df_sub$yields, type = "l", lwd = 2,
               xlab = "Laufzeit (Jahre)", ylab = "Zinssatz",
               main = paste("Laufzeitprofil"), col = colors[i])
          first <- FALSE
        } else {
          lines(df_sub$Laufzeit, df_sub$yields, type = "l", lwd = 2, col = colors[i])
        }
        legend_labels <- c(legend_labels, as.character(date_sel))
      } 
    }
    
    # Falls Daten für mindestens ein Datum vorhanden sind, füge eine Legende hinzu.
    if(length(legend_labels) > 0) {
      legend("topright", legend = legend_labels, col = colors[seq_along(legend_labels)], lwd = 2)
    } else {
      plot.new()
      title(main = paste("Keine Daten verfügbar in der gewählten Laufzeitspanne"))
    }
  })
}

# Startet die Shiny-App mit der definierten Benutzeroberfläche (ui) und der Serverlogik (server)
shinyApp(ui, server)