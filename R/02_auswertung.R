# ------------------------------------------------------------
# Laden der benötigten Pakete:
# dplyr: für datenmanipulation
# purrr: für funktionale Programmierung (z. B. map_dbl)
# tidyr: zum Umformen von Daten (z. B. unnest_longer)
# openxlsx: zum Schreiben von Excel-Dateien
# ------------------------------------------------------------
library(dplyr)
library(purrr)
library(tidyr)
library(openxlsx)

# ------------------------------------------------------------
# Datenbereinigung: Konvertierung der relevanten Spalten
# In den Spalten B0, B1, B2, B3, T1, T2 werden eventuelle Kommas (im Dezimaltrennzeichen)
# durch Punkte ersetzt und die Werte anschließend in numerische Werte konvertiert.
# ------------------------------------------------------------
last_60 <- last_60 %>% 
  mutate(across(c(B0, B1, B2, B3, T1, T2), ~ as.numeric(gsub(",", ".", .))))

# ------------------------------------------------------------
# Filtern der Datensätze:
# Es werden nur jene Zeilen beibehalten, in denen sowohl T1 als auch T2 gültige (nicht NA) Werte ungleich 0 besitzen.
# Dies ist wichtig, um später keine Division durch 0 oder ungültige Berechnungen in der Svensson-Formel zu erhalten.
# ------------------------------------------------------------
last_60_valid <- last_60 %>% 
  filter(!is.na(T1) & T1 != 0,
         !is.na(T2) & T2 != 0)

# ------------------------------------------------------------
# Definition der Laufzeiten:
# Der Vektor 'maturities' enthält die Werte von 1 bis 250 Jahre, für welche die Zinssätze berechnet werden.
# ------------------------------------------------------------
maturities <- 1:250

# ------------------------------------------------------------
# Berechnung der Zinssätze mittels der Svensson-Formel je Tag:
#
# Für jede Zeile im 'last_60_valid'-DataFrame wird – per rowwise() – die folgende Berechnung durchgeführt:
#  - Die Formel enthält vier Parameter: B0, B1, B2, B3 und zwei Zeitparameter T1, T2.
#  - Für jede Laufzeit (maturities) wird die Svensson-Formel angewandt, die eine Liste von Zinssätzen zurückgibt.
#
# Das Ergebnis wird als neue Spalte 'yields' gespeichert, welche pro Zeile eine Liste (Vektor) mit 250 berechneten Zinssätzen enthält.
# ------------------------------------------------------------
last_60_yields <- last_60_valid %>% 
  rowwise() %>% 
  mutate(yields = list(
    B0 + 
      B1 * ((1 - exp(-maturities / T1)) / (maturities / T1)) +
      B2 * (((1 - exp(-maturities / T1)) / (maturities / T1)) - exp(-maturities / T1)) +
      B3 * (((1 - exp(-maturities / T2)) / (maturities / T2)) - exp(-maturities / T2))
  )) %>% 
  ungroup()

# ------------------------------------------------------------
# Erstellung einer Zusammenfassung:
# Hier wird für jede Zeile der berechnete Zinssatz für eine Laufzeit von 1 Jahr und 250 Jahren extrahiert.
#
# - map_dbl() wird verwendet, um aus der 'yields'-Liste den entsprechenden Wert als numerischen Vektor zu extrahieren.
# - Die neuen Spalten 'yield_1yr' und 'yield_250yr' enthalten diese spezifischen Zinssätze.
# - Anschließend werden nur die Spalten Datum, yield_1yr und yield_250yr in 'last_60_summary' ausgewählt.
# ------------------------------------------------------------
last_60_summary <- last_60_yields %>% 
  mutate(yield_1yr = map_dbl(yields, ~ .x[1]),
         yield_250yr = map_dbl(yields, ~ .x[250])) %>% 
  select(Datum, yield_1yr, yield_250yr)

# Ausgabe der Zusammenfassung auf der Konsole
print(last_60_summary)

# ------------------------------------------------------------
# Umwandlung in ein langes Format (Tidy Data):
#
# Zuerst wird aus dem DataFrame 'last_60_yields' nur die Datumsspalte und die 'yields'-Spalte ausgewählt.
# Mit unnest_longer() wird die 'yields'-Liste in mehrere Zeilen "aufgebrochen":
# - Für jede Kombination von Datum und Laufzeit (1 bis 250) wird eine eigene Zeile erzeugt.
# - Der Parameter indices_to = "Laufzeit" benennt die Indexspalte, die den Wert 1 bis 250 erhält.
#
# Abschließend wird die Spalte 'Laufzeit' in einen numerischen Wert umgewandelt.
# ------------------------------------------------------------
yields_long <- last_60_yields %>% 
  select(Datum, yields) %>% 
  unnest_longer(yields, indices_to = "Laufzeit") %>% 
  mutate(Laufzeit = as.numeric(Laufzeit))

# Ausgabe des langformatigen DataFrames mit den berechneten Zinssätzen
print(yields_long)

# ------------------------------------------------------------
# Speichern der Ergebnisse in Excel-Dateien:
#
# 1. Die langformatige Datentabelle (yields_long) wird in einer Excel-Datei gespeichert.
# 2. Der Dateiname enthält das aktuelle Systemdatum, um Versionskontrolle zu erleichtern.
#
# Das write.xlsx() aus dem Paket openxlsx übernimmt den Export.
# ------------------------------------------------------------
output_file_yields <- file.path(folder, paste0("yields_long_", Sys.Date(), ".xlsx"))
write.xlsx(yields_long, output_file_yields)
cat("Excel-Datei mit yields_long wurde gespeichert als:", output_file_yields, "\n")

# ------------------------------------------------------------
# Ausgabe einer Zusammenfassung der letzten 60 Einträge:
# Mit summary() wird eine statistische Zusammenfassung des DataFrames 'last_60' ausgegeben.
# Diese kann genutzt werden, um einen schnellen Überblick über die Verteilung der Daten zu erhalten.
# ------------------------------------------------------------
summary(last_60)

