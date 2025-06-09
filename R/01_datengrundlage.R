# Laden der benötigten Pakete: openxlsx zum Schreiben von Excel-Dateien und dplyr für die Datenmanipulation
library(openxlsx)
library(dplyr)

# ------------------------------------------------------------------
# Definition des Ordnerpfades und der Dateinamen
# Der Ordner "data" enthält die CSV-Dateien mit den unterschiedlichen Parametern.
# Die Vektoren file_names enthält alle Dateinamen, die später eingelesen werden.
# ------------------------------------------------------------------
folder <- "/Users/lutzschubbert/dev7/develop7/data"
file_names <- c(
  "BBSIS.D.I.ZST.B0.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B1.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B2.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.B3.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.T1.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv",
  "BBSIS.D.I.ZST.T2.EUR.S1311.B.A604._Z.R.A.A._Z._Z.A.csv"
)

# ------------------------------------------------------------------
# Funktion zum Einlesen und Verarbeiten einer Parameter-Datei
# Diese Funktion:
# - liest eine CSV-Datei ein, überspringt die ersten 9 Zeilen,
# - benennt die Spalte "fdatum" (falls vorhanden) in "Datum" um,
# - stellt sicher, dass mindestens 2 Spalten vorhanden sind,
# - konvertiert die Datumsspalte in das Date-Format und
# - benennt die zweite Spalte in den gewünschten neuen Spaltennamen um.
# ------------------------------------------------------------------
read_param_file <- function(filepath, new_colname) {
  # Lese CSV mit Semikolon als Trenner ein und überspringe die ersten 9 Zeilen
  df <- read.csv(filepath, skip = 9, header = TRUE, stringsAsFactors = FALSE, sep = ";")
  
  # Wenn die Spalte "fdatum" vorhanden ist, benenne sie in "Datum" um
  if ("fdatum" %in% colnames(df)) {
    colnames(df)[colnames(df) == "fdatum"] <- "Datum"
  }
  
  # Falls keine Spalte "Datum" existiert, setze den Namen der ersten Spalte auf "Datum"
  if (!("Datum" %in% colnames(df))) {
    colnames(df)[1] <- "Datum"
  }
  
  # Konvertiere die Spalte "Datum" in das Date-Format (falls vorhanden)
  if ("Datum" %in% colnames(df)) {
    df$Datum <- as.Date(df$Datum)
  }
  
  # Überprüfen, ob mindestens zwei Spalten vorhanden sind,
  # andernfalls wird ein Fehler ausgegeben.
  if(ncol(df) < 2) {
    stop(paste("Die Datei", filepath, "hat weniger als 2 Spalten."))
  } else {
    # Bennen der zweiten Spalte in den angegebenen neuen Namen (z. B. "B0", "B1", etc.)
    colnames(df)[2] <- new_colname
  }
  
  return(df)
}

# ------------------------------------------------------------------
# Einlesen der einzelnen Parameter-Dateien
# Jede Datei wird mit der read_param_file() Funktion eingelesen.
# Die Dateien werden in den Objekten B0, B1, B2, B3, T1, T2 gespeichert.
# ------------------------------------------------------------------
B0 <- read_param_file(file.path(folder, file_names[1]), "B0")
B1 <- read_param_file(file.path(folder, file_names[2]), "B1")
B2 <- read_param_file(file.path(folder, file_names[3]), "B2")
B3 <- read_param_file(file.path(folder, file_names[4]), "B3")
T1 <- read_param_file(file.path(folder, file_names[5]), "T1")
T2 <- read_param_file(file.path(folder, file_names[6]), "T2")

# ------------------------------------------------------------------
# Zusammenführen der eingelesenen Daten anhand der Spalte "Datum"
# Mit inner_join werden die DataFrames an der gemeinsamen Spalte "Datum" verknüpft.
# Anschließend werden die relevanten Spalten in der gewünschten Reihenfolge ausgewählt.
# ------------------------------------------------------------------
merged <- B0 %>% 
  inner_join(B1, by = "Datum") %>%
  inner_join(B2, by = "Datum") %>%
  inner_join(B3, by = "Datum") %>%
  inner_join(T1, by = "Datum") %>%
  inner_join(T2, by = "Datum") %>%
  select(Datum, B0, B1, B2, B3, T1, T2)

# Optional: Ausgabe der ersten Zeilen, um die Zusammenführung zu überprüfen
print(head(merged))

# ------------------------------------------------------------------
# Erzeugen eines Ausgabedateinamens für die zusammengeführten Daten
# z. B. "Svensson_2025-05-28.xlsx" (das Datum entspricht dem aktuellen Systemdatum)
# ------------------------------------------------------------------
output_file <- file.path(folder, paste0("Svensson_", Sys.Date(), ".xlsx"))

# Speichern der zusammengeführten Daten als Excel-Datei
write.xlsx(merged, output_file)
cat("Datei wurde gespeichert als:", output_file, "\n")

# ------------------------------------------------------------------
# Filtern der Daten:
# - Es werden nur Zeilen extrahiert, bei denen der Wert in B0 nicht NA ist und 
#   nicht nur aus einem Punkt besteht.
# - Der DataFrame wird nach Datum (aufsteigend) sortiert.
# - Die letzten 60 Einträge (entsprechend der 60 Börsentage) werden genommen.
# ------------------------------------------------------------------
last_60 <- merged %>% 
  filter(!is.na(B0) & B0 != ".") %>%  # Filter: B0 darf nicht NA sein und nicht "."
  arrange(Datum) %>%                  # Sortierung nach Datum in aufsteigender Reihenfolge
  tail(60)                            # Auswahl der letzten 60 Einträge

# ------------------------------------------------------------------
# Erzeugen eines neuen Ausgabedateinamens für die letzten 60 Einträge
# z. B. "Svensson_last60_2025-05-28.xlsx"
# ------------------------------------------------------------------
output_file_last60 <- file.path(folder, paste0("Svensson_last60_", Sys.Date(), ".xlsx"))

# Speichern der letzten 60 Einträge in der neuen Excel-Datei
write.xlsx(last_60, output_file_last60)
cat("Excel-Datei mit den letzten 60 Einträgen wurde gespeichert als:", output_file_last60, "\n")


