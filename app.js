/**
 * 1. Aufgaben abhaken (Klick auf eine Task, um sie als erledigt zu markieren) 
 *    und Toggle des zugehörigen ausklappbaren Containers.
 * 2. Simulierter Datei-Upload beim Klick auf "Abgabe hochladen".
 */

// Auswahl aller Elemente mit der Klasse "task" (jede Aufgabe)
document.querySelectorAll('.task').forEach(task => {
  // Initialisiere einen Klick-Zähler für jede Aufgabe (um zwischen erstem und zweitem Klick zu unterscheiden)
  task.clickCount = 0;

  // Event-Listener für Klicks auf das Task-Element
  task.addEventListener('click', (event) => {
    // Falls der Klick innerhalb eines bereits ausklappbaren Bereichs (collapsible-content) erfolgt,
    // soll dieser Klick nicht weiter verarbeitet werden.
    if (event.target.closest('.collapsible-content') !== null) return;

    // Ermittle anhand des data-task-Attributs die jeweilige ID dieser Aufgabe.
    const taskId = task.getAttribute('data-task');
    // Suche den zugehörigen ausklappbaren Bereich, der dieses data-task-Attribut hat.
    const content = document.querySelector(`.collapsible-content[data-task="${taskId}"]`);

    // Falls die Aufgabe bereits als "done" markiert ist:
    // Setze den Ursprungszustand zurück (Aufgabe nicht erledigt, ausklappbaren Bereich schließen)
    if (task.classList.contains('done')) {
      task.classList.remove('done');
      if (content) {
        content.style.display = "none";
      }
      // Klick-Zähler wird zurückgesetzt
      task.clickCount = 0;
      updateProgress(); // Fortschritt aktualisieren
      saveState();      // Zustand im localStorage sichern
      return;           // Beende die weitere Verarbeitung
    }

    // Erhöhe den Klick-Zähler pro Klick
    task.clickCount++;

    if (task.clickCount === 1) {
      // Erster Klick: Öffne den ausklappbaren Container für die zusätzlichen Informationen
      if (content) {
        content.style.display = "block";
      }
    } else if (task.clickCount === 2) {
      // Zweiter Klick: Schließe den Container, markiere die Aufgabe als erledigt
      if (content) {
        content.style.display = "none";
      }
      task.classList.add('done'); // Markiere die Aufgabe als "done" (z.B. wird durch CSS durchgestrichen dargestellt)
      updateProgress();           // Aktualisiere den Fortschrittsbalken (Breite etc.)
      saveState();                // Speichere den aktuellen Zustand (z.B. in localStorage)
      // Setze den Klick-Zähler zurück, damit bei neuem Klick die gleiche Logik wiederholt werden kann
      task.clickCount = 0;
    }
  });
});

// Simulierter Upload-Dialog: Beispielhafte Funktion, die beim Klick auf einen Button mit ID "submitBtn" einen Alert auslöst.
document.getElementById('submitBtn')?.addEventListener('click', () => {
  alert('Datei auswählen und hochladen … (Demo)');
});


/* ---------------- Hilfsfunktionen ------------------ */

// Schlüssel für den localStorage, um den Zustand (welche Aufgaben erledigt sind) zu speichern
const KEY = 'course_tasks_done';

/**
 * Speichert den Zustand der erledigten Aufgaben.
 * Es wird ein Array mit den data-task Werten der erledigten Aufgaben im localStorage gespeichert.
 */
function saveState() {
  const doneIds = [...document.querySelectorAll('.task.done')]
                    .map(t => t.getAttribute('data-task'));
  localStorage.setItem(KEY, JSON.stringify(doneIds));
}

/**
 * Lädt den Zustand (welche Aufgaben erledigt sind) aus dem localStorage.
 * Falls kein Zustand vorhanden ist, wird ein leeres Array zurückgegeben.
 */
function loadState() {
  try {
    return JSON.parse(localStorage.getItem(KEY)) || [];
  } catch {
    return [];
  }
}

/**
 * Aktualisiert den Fortschritt:
 * - Berechnet die Anzahl der erledigten Aufgaben im Verhältnis zur Gesamtzahl.
 * - Passt die Breite des Fortschrittsbalken (#progressBar) per Prozentwert an.
 * - Aktualisiert den Text (#progressText) mit der aktuellen Zählung.
 */
function updateProgress() {
  const total = document.querySelectorAll('.task').length;
  const done = document.querySelectorAll('.task.done').length;
  const percent = total ? (done / total) * 100 : 0;

  document.getElementById('progressBar').style.width = percent + '%';
  document.getElementById('progressText').textContent = `${done} / ${total} erledigt`;
}

/* ---------------- Initialisierung beim Laden der Seite ------------------ */

document.addEventListener('DOMContentLoaded', () => {
  // Lade gespeicherte Zustände der erledigten Aufgaben aus dem localStorage
  const storedDone = loadState();
  // Gehe alle Aufgaben durch und merke sie als "done", wenn sie im gespeicherten Array enthalten sind
  document.querySelectorAll('.task').forEach(task => {
    if (storedDone.includes(task.getAttribute('data-task'))) {
      task.classList.add('done');
    }
  });
  updateProgress(); // Aktualisiere den Fortschritt bei Seitenaufruf
});

/* ---------------- Toggle für extra, aufklappbare Bereiche ------------------ */

// Dieser Code sorgt dafür, dass beim Klick auf eine Überschrift mit der Klasse "collapsible-header"
// der dazugehörige Inhalt (das direkte nächste Geschwisterelement) ein- oder ausgeblendet wird.
document.querySelectorAll('.collapsible-header').forEach(header => {
  header.addEventListener('click', () => {
    const body = header.nextElementSibling;
    // Falls der Body derzeit nicht angezeigt wird (display: none oder leer), zeige ihn an, ansonsten blende ihn aus.
    if (body.style.display === "none" || body.style.display === "") {
      body.style.display = "block";
    } else {
      body.style.display = "none";
    }
  });
});
