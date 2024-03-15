#SingleInstance Force  ; Force l'exécution d'une seule instance du script

SetTitleMatchMode(2)  ; Assure une correspondance partielle du titre de la fenêtre

WinWait("Jacksum")  ; Attends qu'une fenêtre avec "Jacksum" dans le titre s'ouvre
WinWaitActive("Jacksum")  ; Attends que la fenêtre soit active

ControlClick("OK", "Jacksum")  ; Clique sur le bouton OK

WinWaitClose("Jacksum")  ; Attends que la fenêtre se ferme

ExitApp  ; Termine le script une fois la fenêtre fermée
