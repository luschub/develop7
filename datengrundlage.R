library(openxlsx)
library(dplyr)

# Ordnerpfad und Dateinamen
folder <- "/Users/lutzschubbert/dev7/develop7"
file_names <- c(
  "BBSIS.D.I.ZST.B0.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B1.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B2.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B3.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.T1.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.T2.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv"
)

# Funktion zum Einlesen einer Datei: Überspringt die ersten 9 Zeilen,
# prüft auf "fdatum" und wandelt die Datumsspalte um.
read_param_file <- function(filepath, new_colname) {
  # CSV einlesen mit Semikolon als Trenner
  df <- read.csv(filepath, skip = 9, header = TRUE, stringsAsFactors = FALSE, sep = ";")
  
  # Falls "fdatum" vorhanden, umbenennen in "Datum"
  if ("fdatum" %in% colnames(df)) {
    colnames(df)[colnames(df) == "fdatum"] <- "Datum"
  }
  
  # Falls keine Spalte "Datum" existiert, setzen wir den Namen der ersten Spalte auf "Datum"
  if (!("Datum" %in% colnames(df))) {
    colnames(df)[1] <- "Datum"
  }
  
  # Konvertiere die Spalte "Datum" in das Date-Format
  if ("Datum" %in% colnames(df)) {
    df$Datum <- as.Date(df$Datum)
  }
  
  # Überprüfen, ob mindestens 2 Spalten vorhanden sind; benenne dann die 2. Spalte um
  if(ncol(df) < 2) {
    stop(paste("Die Datei", filepath, "hat weniger als 2 Spalten."))
  } else {
    colnames(df)[2] <- new_colname
  }
  
  return(df)
}

# Dateien einlesen
B0 <- read_param_file(file.path(folder, file_names[1]), "B0")
B1 <- read_param_file(file.path(folder, file_names[2]), "B1")
B2 <- read_param_file(file.path(folder, file_names[3]), "B2")
B3 <- read_param_file(file.path(folder, file_names[4]), "B3")
T1 <- read_param_file(file.path(folder, file_names[5]), "T1")
T2 <- read_param_file(file.path(folder, file_names[6]), "T2")

# Zusammenführen der Dateien anhand der Spalte "Datum"
merged <- B0 %>% 
  inner_join(B1, by = "Datum") %>%
  inner_join(B2, by = "Datum") %>%
  inner_join(B3, by = "Datum") %>%
  inner_join(T1, by = "Datum") %>%
  inner_join(T2, by = "Datum") %>%
  select(Datum, B0, B1, B2, B3, T1, T2)

# Optional: Überprüfen, ob alle Werte der gleichen Datum-Zeile zugeordnet wurden
print(head(merged))

# Erzeugen des Ausgabedateinamens, z.B. "Svensson_2025-05-28.xlsx"
output_file <- file.path(folder, paste0("Svensson_", Sys.Date(), ".xlsx"))

# Speichern der zusammengeführten Daten als Excel-Datei
write.xlsx(merged, output_file)
cat("Datei wurde gespeichert als:", output_file, "\n")

# Extrahiere Zeilen, in denen B0 nicht NA ist und nicht nur einen Punkt enthält, und nimm die letzten 60 Einträge
# Sortiere den DataFrame nach Datum (aufsteigend) und filtere die Zeilen
last_60 <- merged %>% 
  filter(!is.na(B0) & B0 != ".") %>% 
  arrange(Datum) %>% 
  tail(60)

# Erzeugen eines neuen Ausgabedateinamens, z.B. "Svensson_last60_2025-05-28.xlsx"
output_file_last60 <- file.path(folder, paste0("Svensson_last60_", Sys.Date(), ".xlsx"))

# Speichern der letzten 60 Einträge in der neuen Excel-Datei
write.xlsx(last_60, output_file_last60)
cat("Excel-Datei mit den letzten 60 Einträgen wurde gespeichert als:", output_file_last60, "\n")


