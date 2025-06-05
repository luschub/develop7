/**
 * 1. Aufgaben abhaken (Klick auf Karte → done) und Toggle des ausklappbaren Containers
 * 2. Simulierter Datei-Upload beim Klick auf „Abgabe hochladen“
 */

document.querySelectorAll('.task').forEach(task => {
  // Initialisiere den Klick-Zähler für jedes Task-Element
  task.clickCount = 0;
  
  task.addEventListener('click', (event) => {
    // Verhindere, dass Klicks innerhalb des collapsible-Contents erneut verarbeitet werden
    if (event.target.closest('.collapsible-content') !== null) return;
    
    // Erhöhe den Klick-Zähler
    task.clickCount++;
    const taskId = task.getAttribute('data-task');
    const content = document.querySelector(`.collapsible-content[data-task="${taskId}"]`);

    if (task.clickCount === 1) {
      // Erster Klick: Öffne den ausklappbaren Container
      if (content) {
        content.style.display = "block";
      }
    } else if (task.clickCount === 2) {
      // Zweiter Klick: Schließe den Container, markiere die Aufgabe als erledigt,
      // update den Fortschritt und setze den Klick-Zähler zurück
      if (content) {
        content.style.display = "none";
      }
      task.classList.add('done');
      updateProgress();
      saveState();
      task.clickCount = 0;
    }
  });
});

/* Simulierter Upload-Dialog */
document.getElementById('submitBtn')?.addEventListener('click', () => {
  alert('Datei auswählen und hochladen … (Demo)');
});

/* ---------- Hilfsfunktionen ---------- */
const KEY = 'course_tasks_done';

function saveState() {
  const doneIds = [...document.querySelectorAll('.task.done')].map(t => t.dataset.task);
  localStorage.setItem(KEY, JSON.stringify(doneIds));
}

function loadState() {
  try {
    return JSON.parse(localStorage.getItem(KEY)) || [];
  } catch {
    return [];
  }
}

function updateProgress() {
  const total = document.querySelectorAll('.task').length;
  const done = document.querySelectorAll('.task.done').length;
  const percent = total ? (done / total) * 100 : 0;

  document.getElementById('progressBar').style.width = percent + '%';
  document.getElementById('progressText').textContent = `${done} / ${total} erledigt`;
}

/* ---------- Initialisierung ---------- */
document.addEventListener('DOMContentLoaded', () => {
  // Lade gespeicherte Zustände und markiere erledigte Aufgaben
  const storedDone = loadState();
  document.querySelectorAll('.task').forEach(task => {
    if (storedDone.includes(task.getAttribute('data-task'))) {
      task.classList.add('done');
    }
    // Optional: Falls Du auch die collapsible-Contents entsprechend initialisieren möchtest,
    // kannst Du hier prüfen, ob sie geöffnet sein sollen.
  });
  updateProgress();
});
