7.1 Die Ermittlung des Basiszinssatzes der Unternehmensbe-
wertung: Herausforderungen und Ansätze
Herausforderungen durch das Äquivalenzprinzip
Der Basiszinssatz ist ein Teil der Opportunitätskosten der Investoren. Damit unterliegt
er dem Äquivalenzprinzip.
Hinsichtlich der Risikoäquivalenz  besteht die Problematik, eine tatsächlich sichere
Investitionsalternative am Kapitalmarkt aufzufinden.  Folgerichtig stellt sich die Frage
nach der Existenz risikoloser Anlagen am Kapitalmarkt. Insbesondere im deutschen
Sprachraum mag der Verweis auf die Rendite von Staatsanleihen noch einen hinrei-
chend guten Schätzer für den Zinssatz auf risikolose Anlagen bieten. Jedoch stellt sich
die Frage, wie in Ländern zu verfahren ist, deren Staatsanleihen nicht als sicher gelten
können, deren Renditen also einen teilweise erheblichen Risikoaufschlag beinhalten.
Keine Lösung für diese Problem bietet der Verweis auf die Staatsanleihen anderer
Staaten, da häufig  in derartigen Hochrisikostaaten Kapitalmarktsperren herrschen und
eine Anlage im Ausland verboten oder mit hohen Steuern belegt ist. Weiterhin birgt
eine Anlage im Ausland das Problem, dass die Forderung nach Währungsäquivalenz
nicht eingehalten werden kann. Generell ist auch zu hinterfragen, was zu tun wäre,
wenn zu irgendeinem Zeitpunkt in der Zukunft kein Staat mehr als risikolos gelten
kann.
Hinsichtlich der Laufzeitäquivalenz  besteht die Problematik, eine laufzeitäquivalente
Investitionsalternative zu bestimmen. Die Unternehmensbewertung arbeitet mit un-
endlichen Planungshorizonten. Deshalb ergibt sich die Fragestellung, ob am Kapital-
markt überhaupt derart langlebige Investitionsalternativen vorhanden sind. Alternativ
stellt sich die Frage, ob eine Extrapolation kurzfristiger Anlagerenditen für die Bewer-
tung langfristiger Zahlungsreihen statthaft ist.
Ansätze zur Ermittlung des Basiszinssatzes
Der vorliegende Abschnitt zeigt zwei Möglichkeiten der Ermittlung des Basiszinssatzes
bzw. der sogenannten Zinsstrukturkurve  auf. Die erste Alternative ist die Ermittlung
der Zinsstrukturkurve anhand von Staatsanleihen , der zweite Abschnitt zeigt die Er-
mittlung risikoloser Anlagerenditen anhand von Swapgeschäften  auf. In einem wei-
teren Schritt soll eine Regressionsmethode entwickelt werden, die gefundenen Daten-
punkt an eine mathematische Funktion anzupassen. Es werden die Ansätze von NEL-
SON/SIGEL und SVENSSON aufgegriffen.7 Fortgeschrittene Fragen der Unternehmensbewer-
tung7.2 Die Zinsstruktur auf Basis der Rendite von Staatsan-
leihen
186 / 274
7.2 Die Zinsstruktur auf Basis der Rendite von Staatsanleihen
Die Rendite von Bundesanleihen, die über die Börse gehandelt werden, kann errechnet
werden. Es handelt sich bei ihrer Rendite um den internen Zinsfuß der Zahlungsreihe
der Anleihe, wenn man den aktuellen Börsenkurs als Anfangsinvestition berücksich-
tigt. Anders ausgedrückt handelt es sich um denjenigen Zins r, der beim aktuellen
Marktniveau einen Kapitalwert von null errechnet.

FormelNennwert ⋅Kurs +Stückzinsen =
t= 1TKupon t+Rückzahlung t
1 +rt
 Form. 91: Formel 7.1: Rendite von Bundesanleihen
.
Bereits aus den Grundlagenveranstaltungen der Betriebswirtschaftslehre ist bekannt,
dass der interne Zinsfuß einer Zahlungsreihe nicht ohne weiteres bestimmbar ist.
Obige Formel lässt sich nämlich nur dann nach r auflösen,  wenn der Anlagezeitraum
zwei Perioden nicht überschreitet. In allen anderen Fällen liegt ein Polynom dritten
oder höheren Grades vor. Jedoch können in solchen Fällen Nährungsalgorithmen, wie
die Regula Falsi , also das Sekantenverfahren , für die Lösung herangezogen werden.
Diese führen zumindest dann zu einer Lösung, wenn die Zahlungsreihe nicht mehr als
einen Vorzeichenwechsel aufweist. Dies sollte bei Investitionen in Anleihen jedoch in
aller Regel gegeben sein.

DefinitionErmittelt man nun die Rendite aller am Markt gehandelten Staatsanleihen, so erlaubt
die Gegenüberstellung aus Laufzeit und Rendite bereits eine erste Abschätzung der
Zeitstruktur der Zinsen, also der Zinsstrukturkurve. Die auf diese Weise erhaltene
Struktur nennt sich Renditestruktur .
.
Fehler dieses Ansatzes
Jedoch beinhaltet diese Methode einen inhärenten Fehler. Übliche Festzinsanleihen
weisen jährliche Kuponzahlungen auf. Betrachtet man jede einzelne Kuponzahlung als
eigenständige Investitionsrückzahlung, so gilt für jede dieser Zahlungen eine eigene
Rendite. Obige Formel müsste also lauten:

FormelNennwert ⋅Kurs +Stückzinsen =
t= 1TKupon t+Rückzahlung t
1 +r0,tt
 Form. 92: Formel 7.2: Korrigierte Renditestruktur
.7 Fortgeschrittene Fragen der Unternehmensbewer-
tung7.2 Die Zinsstruktur auf Basis der Rendite von Staatsan-
leihen
187 / 274
Lösungsansätze
Eine Lösung dieses Dilemmas liegt darin, lediglich Nullkuponanleihen für die Berech-
nung heranzuziehen, da diese keine Kuponzahlungen aufweisen. Verwendet man auss-
chließlich Nullkuponanleihen, erhält man die Zero Curve . Jedoch existieren am Markt
üblicherweise nicht genügend Nullkuponanleihen, um hieraus eine Zinsstrukturkurve
herzuleiten. Lediglich im sehr kurzfristigen Bereich ist dies möglich, da eine Anleihe
kurz vor ihrer Rückzahlung keinen Kupon mehr aufweist und daher mit einer Nullku-
ponanleihe identisch ist.
Eine andere Lösung ist die Umrechnung von Anleiherenditen in Nullkuponrenditen.
Hierfür wird das so genannte Bootstrapping-Verfahren  eingesetzt. Beim Bootstrap-
ping-Verfahren werden die Kupons einer Staatsanleihe als selbstständige Zahlungs-
ströme aufgefasst, die einzeln bewertet werden. Aufgrund des Zusammenhangs aus
Spot-Zinssatz und Forward-Zinssatz (siehe Lernabschnitt 2: Der Unternehmenswert
aus ökonomischer Sicht) kann die Rendite jeder einzelnen Kuponzahlung errechnet
werden. Begonnen wird dabei in einem ersten Schritt mit einjährigen Anleihen, da
diese keine Kuponzahlungen mehr vor dem Rückzahlungsdatum aufweisen. Deren
Rendite entspricht der Spot-Rate r0, 1 und ist leicht errechenbar. Nun kann man sich
den zweijährigen Anleihen widmen. Unter Verwendung von Formel zur korrigierten
Renditestruktur  kann auf die Spot-Rate r0, 2 geschlossen werden, da die Spot-Rate r0, 1
und die Rendite der Anleihe bekannt sind. Durch Fortsetzung dieses Verfahrens und
Anwendung auf Anleihen mit längeren Laufzeiten, können sämtliche, am Markt beo-
bachtbaren Spot-Rates r0,t ermittelt werden. Trägt man diese Renditen in ein Laufzeit/
Renditediagramm ein, so erhält man ein Streupunktdiagramm, das einen ersten Blick
auf den Zusammenhang von Laufzeit und Rendite erlaubt. Man erhält die so genannte
Bondkurve .
7.3 Die Zinsstruktur auf Basis impliziter Renditen von Swapge-
schäften
Swapgeschäfte gehören zu den derivativen Finanzinstrumenten, da ihr Wert von der
Wertentwicklung anderer Marktgrößen abhängt. Zinsswaps  sind die einfachste und
ursprünglichste Form von Swapgeschäften. Sie dienen der Absicherung gegen Zinsän-
derungsrisiken.

BeispielDie Funktion von Zinsswaps kann man sich am besten als gegenseitige Gewährung von
Krediten zwischen zwei Parteien vorstellen. Partei A gewährt Partei B einen Festzin-
skredit über einen Nennwert NW  zu einem Zinssatz von a%. Partei B gewährt Partei A7 Fortgeschrittene Fragen der Unternehmensbewer-
tung7.3 Die Zinsstruktur auf Basis impliziter Renditen von
Swapgesc...
188 / 274
einen variabel verzinslichen Kredit über den gleichen Nennwert NW  zum
EURIBOR +b%.
.
Ein Zinsswap dient folglich dazu, Festzinsgeschäfte in variabel verzinsliche Geschäfte
umzuwandeln und umgekehrt.
Bei einer gegenseitigen Kreditgewährung über den gleichen Nennwert ist der Aus-
tausch des Kreditbetrags entbehrlich. Während der Laufzeit des Zinsswaps werden le-
diglich die Zinszahlungen gezahlt bzw. die Spitzen zwischen ihnen ausgeglichen. Zinss-
waps werden üblicherweise zu Laufzeitbeginn so abgeschlossen, dass sich kein Markt-
wert des Swapgeschäfts ergibt. Das ist immer dann der Fall, wenn beide kontrahierten
Zinssätze marktgerecht sind. Im weiteren Verlauf des Swapgeschäfts können sich je-
doch positive oder negative Marktwerte einstellen, sofern sich das Zinsniveau verän-
dert, sich also die Zinsstrukturkurve verschiebt.
Risiken
Da bei einem Zinsswap zu keinem Zeitpunkt der Nennwert ausgetauscht wird, ergibt
sich kein Kreditausfallrisiko . Lediglich ein Kontrahentenrisiko  ist festzustellen. Es
bezieht sich auf den möglichen Verlust eines positiven Marktwerts bei Ausfall des Kon-
trahenten. Vernachlässigt man das Kontrahentenrisiko, so lassen sich aus den kontra-
hierten Zinssätzen ebenfalls Datenpunkte für die Ermittlung der Zinsstruktur gewin-
nen. Es entsteht die so genannte Swap-Kurve . Aufgrund des Kontrahentenrisikos und
aufgrund der hohen Beliebtheit von Staatsanleihen ist jedoch die Swapkurve stets et-
was höher, als die Goverment- bzw. Souvereign-Curve .
7.4 Regressionmethoden nach NELSON/SIGEL und SVENSSON

Gliederung7.4 Regressionmethoden nach NELSON/SIGEL und SVENSSON
 7.4.1 Das NELSON/SIEGEL-Modell
 7.4.2 Erweiterung nach SVENSSON
 7.4.3 Anpassungen des IDW
.
Bereits im Lernabschnitt 2: Der Unternehmenswert aus ökonomischer Sicht  wurde auf
die Zeitstruktur der Zinsen hingewiesen. Die Zinsstrukturkurve, die die Abhängigkeit
der Rendite von der Laufzeit aufzeigt, weist üblicherweise einen mit der Laufzeit der
Anlage steigenden Verlauf auf. Aber auch andere Verläufe sind möglich. So sind von
Zeit zu Zeit flache  Verläufe der Zinsstrukturkurve beobachtbar. Genauso ist eine fall-
ende, eine sogenannte inverse Zinsstruktur möglich. Nichts läge nun näher, als die An-7 Fortgeschrittene Fragen der Unternehmensbewer-
tung7.4 Regressionmethoden nach NELSON/SIGEL und
SVENSSON
189 / 274
passung einer mathematischen Funktion an die in den letzten Abschnitten entwickel-
ten Datenpunkte mittels der Methode der kleinsten Quadrate . Es stellt sich demnach
die Frage welche mathematische Funktion am besten in der Lage ist, die verschiede-
nen beobachtbaren Verläufe der Zinsstruktur bestmöglich abzubilden.
7.4.1 Das NELSON/SIEGEL-Modell
Ein erster Vorschlag stammt von NELSON/SIEGEL, die folgende Formel für die An-pas-
sung an das Streupunktdiagramm vorschlagen (vgl. Diebold und Li 2006  , S.337  ff. ):

FormelrT,β0,β1,β2,τ1=β0+β11−e−T/τ1
T/τ1+β21−e−T/τ1
T/τ1−e−T/τ1
 Form. 93: Formel 7.3: Nelson/Siegel-Modell
.
 Abb. 35: Regression zur Ermittlung der Zinsstrukturkurve
Die Zinsstrukturkurve kann sehr unterschiedliche Verläufe nehmen, so dass eine Funktion zu ihrer Abbil-
dung sehr flexibel  auf die möglichen Kurvenverläufe anpasst war sein muss. Die Anpassung geschieht
durch die Anwendung der Methode der kleinsten Quadrate, also durch Regression
Quelle: Vgl. Diebold, Francis X. und Li, Canlin (2006), S. 337 ff.7.4 Regressionmethoden nach NELSON/SIGEL und
SVENSSON7.4.1 Das NELSON/SIEGEL-Modell
190 / 274
7.4.2 Erweiterung nach SVENSSON
Der Vorschlag von NELSON/SIEGEL konnte bereits die Zinsstruktur in ihren üblichen
Verläufen gut abbilden. Insbesondere s-förmige Verläufe der Zinsstruktur sind jedoch
nicht darstellbar. Aus diesem Grund schlägt SVENSSON folgende Erweiterung des NEL-
SON/SIEGEL-Modells vor:

FormelrT,β0,β1,β2,β3,τ1,τ2=β0+β11−e−T/τ1
T/τ1+β21−e−T/τ1
T/τ1−e−T/τ1
+β31−e−T/τ2
T/τ2−e−T/τ2
 Form. 94: Formel 7.4: Erweitertes Nelson/Siegel-Modell nach SVENSSON
.
Die NELSON/SIEGEL-Funktion wird um einen weiteren Summanden erweitert, der ei-
nen weiteren Wendepunkt in der Kurve ermöglicht. Die Zinsstrukturkurve wird nun
als Funktion von sechs Parametern ( β0,β1,β2,β3,τ1,τ2) und der Laufzeit T beschrie-
ben. Die sechs genannten Parameter gilt es durch Regression zu schätzen. Eine beson-
dere Rolle kommt in der SVENSSON-Formel dem Parameter β0 zu. Strebt die Laufzeit
gegen unendlich, geht der Beitrag der Exponentialterme gegen null. Damit konvergiert
die Funktion mit zunehmender Laufzeit gegen den Parameter β0.
FazitEs hat sich gezeigt, dass die SVENSSON Regression gegenüber dem ursprünglichen
Modell von NELSON/SIEGEL deutlich bessere Teststatistiken aufweist. Aus diesem
Grund hat sich das SVENSSON-Modell durchgesetzt. Es wird vor allem durch die
DEUTSCHE BUNDESBANK für deren Kapitalmarktstatistik genutzt (vgl. Deutsche Bun-
desbank 1997  ). Die sechs Regressionsparameter werden börsentäglich durch die Bun-
desbank veröffentlicht. Insofern ist es für den Anwender nicht mehr notwendig, das
aufwändige Bootstrapping und die Regressionsanalyse selber durchzuführen. Es kann
vereinfachend auf die von der Bundesbank erhobenen Parameter zurückgegriffen
werden. Die auf diese Weise ermittelten Zinssätze sind, je nach gewünschter Verwen-
dung, noch von stetigen in diskrete Zinssätze umzurechnen.
.7.4 Regressionmethoden nach NELSON/SIGEL und
SVENSSON7.4.2 Erweiterung nach SVENSSON
191 / 274
7.4.3 Anpassungen des IDW
Aufgrund der Regressionsmethodik kann es im Einzelfall zu kleineren Verzerrungen
der Zinsstrukturkurve kommen. Aus diesem Grund schlägt das Institut der Wirtschaft-
sprüfer (IDW) eine Glättung der Zinsstrukturkurve vor.
Um dies bei der Ermittlung von Unternehmenswerten nach IDW S 1 zu erreichen, sind
die Parameter der Bundesbank über drei Monate hinweg zu mitteln. Hierfür wird für
jeden Börsentag innerhalb dieser drei Monate die Zinsstrukturkurve für die Laufzeiten
von einem bis zu 250 Jahren ausgerollt. Sodann wird der durchschnittliche Zins für
jede dieser Stützstellen errechnet. Auf diese Weise erhält man eine weitestgehend ver-
zerrungsfreie Zinsstrukturkurve.

AnmerkungDiese Zinsstrukturkurve ist aufgrund der Mittelwertbildung jedoch nicht taggenau. In-
sbesondere bei starken Veränderungen der Zinsstrukturkurve im Laufe der Zeit, führt
diese Methode zur Verwendung einer Zinsstruktur die im Schnitt eineinhalb Monate
alt ist.
.
Weiterhin schlägt das IDW aus Vereinfachungsgründen vor, aus der Zinsstrukturkurve
einen einheitlichen Basiszinssatz abzuleiten. Hierfür ist eine typisierte, mit gleich blei-
bender Rate wachsende Zahlungsreihe mittels der Zinsstrukturkurve abzuzinsen. Der
hieraus errechnete Barwert wird wiederum als Anfangsinvestition für die Berechnung
des internen Zinsfußes der Zahlungsreihe verwendet. Dieser interne Zinsfuß kann
dann als periodenunabhängiger Kapitalisierungszins verwendet werden. Zumindest
auf die Verbarwertung der typisierten Zahlungsreihe hat es dann keinen Einfluss,  ob
mittels der periodenspezifischen  Zinssätze der Zinsstrukturkurve oder mittels des ein-
heitlichen Basiszinssatz abgezinst wird.

AnmerkungAuch dieses Vorgehen ist jedoch zu hinterfragen. Durch die Länge des typisierten Zah-
lungsstroms erhalten die Zinssätze mit langer Laufzeit ein deutlich höheres Gewicht
gegenüber den Zinssätzen mit kurzer Laufzeit. Hierdurch wird implizit die Bedeutung
der sehr ungenau schätzbaren Fortführungsperiode gestärkt. Die Abzinsung der recht
akkurat schätzbaren Ergebnisse der Detailplanungsphase hingegen geschieht mittels
verzerrter Zinssätze. Ein besseres Vorgehen böte die Möglichkeit, lediglich die Zinssä-
tze der Fortführungsperiode in einen Einheitszinssatz umzurechnen und innerhalb
der Detailplanungsphase mit periodengenauen Spotzinssätzen zu arbeiten.
.7 Fortgeschrittene Fragen der Unternehmensbewer-
tung7.5 Übungsaufgaben zum Kapitel: Fortgeschrittene Fra-
gen der Unt...
192 / 274
7.5 Übungsaufgaben zum Kapitel: Fortgeschrittene Fragen der
Unternehmensbewertung

Gliederung7.5 Übungsaufgaben zum Kapitel: Fortgeschrittene Fragen der Unternehmensbewer-
tung
 7.5.1 Lückentext zu Kapitel 7
 7.5.2 Multiple-Choice zu Kapitel 7
 7.5.3 Develop zu Kapitel 7
.
7.5.1 Lückentext zu Kapitel 7

Aufgabe Aufg. 39: Quiz: Lückentext 1
 An dieser Stelle befindet  sich online ein interaktives Medienelement.
https://vfhuwert.eduloop.de/loop/L%C3%BCckentext_zu_Kapitel_7
 Aufg. 40: Quiz: Lückentext 2
 An dieser Stelle befindet  sich online ein interaktives Medienelement.
https://vfhuwert.eduloop.de/loop/L%C3%BCckentext_zu_Kapitel_7
 Aufg. 41: Quiz: Lückentext 3
 An dieser Stelle befindet  sich online ein interaktives Medienelement.
https://vfhuwert.eduloop.de/loop/L%C3%BCckentext_zu_Kapitel_7
.
7.5.2 Multiple-Choice zu Kapitel 7

Aufgabe Aufg. 42: Multiple-Choice-Quiz
Die folgenden Multiple-Choice-Fragen beinhalten jeweils vier mögliche Antworten,
von denen mindestens eine richtig ist. Maximal sind sämtliche Antworten richtig. 
 An dieser Stelle befindet  sich online ein Quiz.
https://vfhuwert.eduloop.de/loop/Multiple-Choice_zu_Kapitel_7
.7.5 Übungsaufgaben zum Kapitel: Fortgeschrittene
Fragen der Unternehmensbewertung7.5.1 Lückentext zu Kapitel 7
193 / 274
7.5.3 Develop zu Kapitel 7

Aufgabe Leiten Sie den aktuell gültigen Basiszinssatz nach den Empfehlungen des IDW her.
.
Gehen Sie dabei folgendermaßen vor:
•Besorgen Sie sich die Parameter des Svensson-Modells von der Internetpräsenz
der Deutschen Bundesbank. Nutzen Sie die Zeitreihe der letzten drei Monate bzw.
60  Tage.
•Berechnen Sie mittels der Parameter für alle 60  Tage jeweils die gültigen Zinssä-
tze für die Laufzeiten von einem Jahr bis 250  Jahre.
•Errechnen Sie den Mittelwert der Zinssätze für jede Laufzeit von einem Jahr bis
250  Jahre.
•Rechnen sie den Zinssatz jeder Laufzeit von stetigen in diskrete Renditen um.
•Stellen Sie die Kurve grafisch  dar.
•Rechnen Sie die Laufzeiten der IDW-Empfehlung folgend in einen laufzeitunab-
hängigen Basiszinssatz um.
