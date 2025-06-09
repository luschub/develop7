# Develop-Aufgabe 7  
**Kurs:** Unternehmensbewertung und wertorientierte Unternehmensführung (FHK BWLM 13 S25)  
**Student:** Lutz Schubbert  
**Präsentationsdatum:** 10.06.2025  

---

## Projektbeschreibung

Diese GitHub-Seite dokumentiert meine Lösung zur **Develop-Aufgabe 7** im Rahmen des o.g. Kurses.  
Ziel der Aufgabe war es, den aktuell gültigen **Basiszinssatz gemäß den Empfehlungen des IDW** zu ermitteln und die dazugehörigen Rechen- und Analyse-Schritte nachvollziehbar darzustellen.

Ich habe mich bewusst entschieden, die Aufgabe **nicht in klassischer Form (PPT und Excel)**, sondern als **interaktive Website** und mit **vollständiger Berechnung in R** umzusetzen.  
Die Website ist hier öffentlich zugänglich:  
👉 [https://luschub.github.io/develop7/](https://luschub.github.io/develop7/)

---

## Technisches Vorgehen

- **R-Skripte:** Alle Berechnungen und Datenaufbereitungen wurden mit R durchgeführt.
- **Shiny App:** Visualisierung der Zinsstrukturkurve über eine interaktive Shiny App.
- **Webseite:** Umsetzung der Dokumentation als Website (HTML/CSS/JS), veröffentlicht via GitHub Pages.
- **Versionierung:** Nutzung von Git und GitHub für die Versionskontrolle und Dokumentation des Arbeitsfortschritts.

---

## Aufgabenstellung

1. **Datenbeschaffung:**  
   → Offizielle Svensson-Parameter der Deutschen Bundesbank beschaffen.  

2. **Berechnung der Zinsstrukturkurve:**  
   → Für 60 Handelstage, Laufzeiten 1 bis 250 Jahre.  

3. **Mittelwertberechnung:**  
   → Mittelwert der Zinssätze je Laufzeit.  

4. **Umrechnung:**  
   → Stetig verzinste Zinssätze in diskrete Renditen umrechnen.  

5. **Grafische Darstellung:**  
   → Zinsstrukturkurve visualisieren.  

6. **Laufzeitunabhängiger Basiszinssatz (IDW):**  
   → Ermittlung und Darstellung.

---

## Projektstruktur

```
├── index.html           # Hauptseite (GitHub Pages)
├── style.css            # Stylesheet
├── app.js               # Interaktives Verhalten
├── /images              # Screenshots und erzeugte Diagramme
│   ├── bundesbank_screenshot.png
│   ├── grafische_Darstellung_diskreter_Renditen.png
│   ├── basiszinssatz_verlauf.png
├── /R                   # R-Skripte für die Berechnungen
│   ├── 01_import_parameters.R
│   ├── 02_calculate_yields.R
│   ├── 03_mean_yields.R
│   ├── 04_convert_to_discrete.R
│   ├── 05_plot_yields.R
│   ├── 06_calculate_basis_rate.R
├── /shiny_app           # Shiny App inkl. Daten
│   ├── app.R
│   ├── /data
├── /data                # Rohdaten und erzeugte Dateien
│   ├── raw_data
│   ├── processed_data
│   ├── exports
└── README.md            # Diese Datei
```

---

## Hinweise

- Die **offizielle Quelle** der Svensson-Parameter ist:  
  👉 [https://www.bundesbank.de/de/statistiken/geld-und-kapitalmaerkte/zinssaetze-und-renditen/taegliche-zinsstruktur-fuer-boersennotierte-bundeswertpapiere-650724](https://www.bundesbank.de/de/statistiken/geld-und-kapitalmaerkte/zinssaetze-und-renditen/taegliche-zinsstruktur-fuer-boersennotierte-bundeswertpapiere-650724)

- Die Entwicklung wurde auf **macOS** mit **Visual Studio Code** und **R (RStudio)** durchgeführt.

- Die R-Skripte sind so dokumentiert, dass alle Schritte **reproduzierbar** sind.

---

## Lizenz

Dieses Repository dient ausschließlich der **dokumentierten Abgabe im Rahmen der Hochschulveranstaltung** und ist nicht für kommerzielle Nutzung bestimmt.

---

## Kontakt

Lutz Schubbert  
[GitHub-Profil](https://github.com/luschub)
