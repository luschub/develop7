library(dplyr)
library(purrr)
library(tidyr)
library(openxlsx) # Für die write.xlsx Funktion

# Konvertiere die relevanten Spalten, indem Kommas durch Punkte ersetzt werden
last_60 <- last_60 %>% 
  mutate(across(c(B0, B1, B2, B3, T1, T2), ~ as.numeric(gsub(",", ".", .))))

# Filtere nur Zeilen, in denen T1 und T2 gültige Werte ungleich 0 sind
last_60_valid <- last_60 %>% 
  filter(!is.na(T1) & T1 != 0,
         !is.na(T2) & T2 != 0)

# Laufzeiten von 1 bis 250 Jahre
maturities <- 1:250

# Berechnung der Zinssätze mittels Svensson-Formel pro Tag
last_60_yields <- last_60_valid %>% 
  rowwise() %>% 
  mutate(yields = list(
    B0 + 
      B1 * ((1 - exp(-maturities / T1)) / (maturities / T1)) +
      B2 * (((1 - exp(-maturities / T1)) / (maturities / T1)) - exp(-maturities / T1)) +
      B3 * (((1 - exp(-maturities / T2)) / (maturities / T2)) - exp(-maturities / T2))
  )) %>% 
  ungroup()

# Beispiel: Ausgabe des Zinssatzes für 1 Jahr (erste Laufzeit) und 250 Jahre (letzte Laufzeit)
last_60_summary <- last_60_yields %>% 
  mutate(yield_1yr = map_dbl(yields, ~ .x[1]),
         yield_250yr = map_dbl(yields, ~ .x[250])) %>% 
  select(Datum, yield_1yr, yield_250yr)

print(last_60_summary)

# Umwandlung in ein langes Format: je Zeile ein Datum und die dazugehörige Laufzeit (1 bis 250) mit dem berechneten Zinssatz
yields_long <- last_60_yields %>% 
  select(Datum, yields) %>% 
  unnest_longer(yields, indices_to = "Laufzeit") %>% 
  mutate(Laufzeit = as.numeric(Laufzeit))

# Ausgabe der berechneten Zinssätze im langen Format
print(yields_long)

# Speichern der yields_long Daten in einer Excel-Datei
output_file_yields <- file.path(folder, paste0("yields_long_", Sys.Date(), ".xlsx"))
write.xlsx(yields_long, output_file_yields)
cat("Excel-Datei mit yields_long wurde gespeichert als:", output_file_yields, "\n")

summary(last_60)