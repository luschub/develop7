# ------------------------------------------------------------
# Umrechnung von stetig in diskrete Renditen:
#
# Für jeden Zinssatz in 'yields_long$yields' (kontinuierlich verzinster Zinssatz)
# wird der diskrete Zinssatz berechnet. 
#
# Formel: R_diskret = exp(R_stetig) - 1
#
# Diese Umrechnung liefert den Zinssatz, der auf diskreter Verzinsung basiert,
# was häufig in der Praxis gebraucht wird.
# ------------------------------------------------------------
yields_long <- yields_long %>% 
  mutate(disc_yields = exp(yields) - 1)

# Ausgabe der ersten Zeilen des erweiterten DataFrames, um die Umrechnung zu überprüfen
print(head(yields_long))

# ------------------------------------------------------------
# Optional: Speichern des erweiterten DataFrames mit der neuen Spalte in einer Excel-Datei
#
# Der Dateiname enthält das aktuelle Systemdatum zur besseren Versionskontrolle.
# ------------------------------------------------------------
output_file_disc <- file.path(folder, paste0("yields_long_disc_", Sys.Date(), ".xlsx"))
write.xlsx(yields_long, output_file_disc)
cat("Excel-Datei mit diskreten Renditen wurde gespeichert als:", output_file_disc, "\n")

# ------------------------------------------------------------
# Berechnung des Mittelwerts der Zinssätze pro Laufzeit (1 bis 250 Jahre):
# Wir gruppieren das long-formatige DataFrame 'yields_long' nach der Spalte 'Laufzeit'
# und berechnen den Mittelwert der Zinssätze für jede Laufzeit. Dabei werden NA-Werte ignoriert.
# ------------------------------------------------------------
mean_yields <- yields_long %>% 
  group_by(Laufzeit) %>% 
  summarise(mean_yield = mean(yields, na.rm = TRUE))

# Ausgabe der Mittelwerte pro Laufzeit
print(mean_yields)

# ------------------------------------------------------------
# Optional: Speichern der Mittelwerte in einer Excel-Datei.
# Der Dateiname enthält das aktuelle Systemdatum für eine einfache Versionskontrolle.
# ------------------------------------------------------------
output_file_meanyields <- file.path(folder, paste0("mean_yields_", Sys.Date(), ".xlsx"))
write.xlsx(mean_yields, output_file_meanyields)
cat("Excel-Datei mit mean_yields wurde gespeichert als:", output_file_meanyields, "\n")

# ------------------------------------------------------------
# Grafische Darstellung der Zinssatz-Kurve:
#
# Wir verwenden ggplot2, um zwei Ebenen darzustellen:
# 1. Einzelkurven aus 'yields_long': Diese werden in einem hellen Grauton 
#    mit leichter Transparenz eingezeichnet, um die individuelle Varianz der
#    Zinssätze pro Datum zu zeigen.
# 2. Die Durchschnittskurve aus 'mean_yields': Diese wird als rote, dicke Linie
#    dargestellt, um den Mittelwert der Zinssätze pro Laufzeit hervorzuheben.
# ------------------------------------------------------------

# Sicherstellen, dass ggplot2 geladen ist
library(ggplot2)

# Erstellen des Plots:
p <- ggplot() +
  # Zeichnen der individuellen Zinssatzverlaufs-Kurven pro Datum (grau, transparent)
  geom_line(data = yields_long, aes(x = Laufzeit, y = yields, group = Datum),
            color = "grey80", alpha = 0.5) +
  # Zeichnen der durchschnittlichen Zinssatz-Kurve (rot, dick)
  geom_line(data = mean_yields, aes(x = Laufzeit, y = mean_yield),
            color = "red", size = 1.5) +
  # Beschriftung der Achsen und Titel
  labs(title = "Zinssatz-Kurve pro Laufzeit (1 bis 250 Jahre)",
       subtitle = "Einzelne Tageskurven (grau) und durchschnittliche Kurve (rot)",
       x = "Laufzeit (Jahre)",
       y = "Stetig verzinster Zinssatz") +
  # Verwendung eines cleanen Themes
  theme_minimal()

# Ausgabe des Plots
print(p)

# ------------------------------------------------------------
# Laufzeitunabhängiger Basiszinssatz (IDW):
#
# Ziel: Für jedes Datum soll ein einzelner Basiszinssatz ermittelt werden, der
# die Zinssätze über alle Laufzeiten (1 bis 250 Jahre) zusammenfasst. 
#
# Ansatz: Gruppiere das lang-formatige DataFrame 'yields_long' nach Datum.
# Für jede Gruppe wird der Mittelwert der stetig verzinsten Zinssätze (Spalte "yields")
# über alle Laufzeiten berechnet. Hierdurch entsteht ein Zinssatz, der nicht mehr von 
# der Laufzeit abhängt – also ein Basiszinssatz.
#
# Hinweis: Alternativ könnte eine gewichtsbasierte Integration erfolgen, sofern 
# entsprechende Gewichtungsfunktionen vorliegen. Im folgenden Beispiel wird jedoch der 
# einfache arithmetische Mittelwert verwendet.
# ------------------------------------------------------------
basis_zinssatz <- yields_long %>% 
  group_by(Datum) %>% 
  summarise(basis_zinssatz = mean(yields, na.rm = TRUE))

# Ausgabe der berechneten Basiszinssätze pro Datum
print(basis_zinssatz)

# ------------------------------------------------------------
# Optional: Speichern der Basiszinssätze in einer Excel-Datei.
# Der Dateiname enthält das aktuelle Systemdatum zur besseren Versionskontrolle.
# ------------------------------------------------------------
output_file_basis <- file.path(folder, paste0("basis_zinssatz_", Sys.Date(), ".xlsx"))
write.xlsx(basis_zinssatz, output_file_basis)
cat("Excel-Datei mit Basiszinssätzen wurde gespeichert als:", output_file_basis, "\n")

# ----------------------------------------------------------------------
# Berechnung des laufzeitunabhängigen Basiszinssatzes und dessen Visualisierung
# ----------------------------------------------------------------------

# Basiszinssatz berechnen: Gruppierung nach Datum, um den durchschnittlichen
# stetig verzinsten Zinssatz zu ermitteln
basis_zinssatz <- yields_long %>% 
  group_by(Datum) %>% 
  summarise(basis_zinssatz = mean(yields, na.rm = TRUE))

# Plot erstellen mit ggplot2
library(ggplot2)

p_basis <- ggplot(basis_zinssatz, aes(x = Datum, y = basis_zinssatz)) +
  geom_line(color = "blue", size = 1.2) +
  labs(title = "Verlauf des laufzeitunabhängigen Basiszinssatzes (IDW)",
       x = "Datum (Handelstag)",
       y = "Basiszinssatz (stetig verzinst)") +
  theme_minimal()

# Plot anzeigen
print(p_basis)

# Plot als PNG speichern
ggsave(filename = "images/basiszinssatz_verlauf.png", plot = p_basis, width = 8, height = 5, dpi = 300)