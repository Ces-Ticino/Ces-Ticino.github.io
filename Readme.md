# Jahr der Artenvielfalt Ces 2024 – Berichte

Dieses Projekt enthält zwei Berichte zum Jahr der Artenvielfalt Ces 2024:

- **Publikumsbericht** – eine HTML-Website, die online abrufbar ist
- **Technischer Bericht** – ein ausführliches PDF-Dokument

Der Publikumsbericht ist online abrufbar unter: https://www.cesbiodiv.ch

Der Technische Bericht wurde als PDF an die Auftraggeber abgegeben.

---

## Voraussetzungen

Um die Berichte lokal zu erstellen, muss **Quarto** auf dem Computer installiert sein.

Quarto ist kostenlos und kann hier heruntergeladen werden: https://quarto.org/

Nach der Installation kann man überprüfen, ob Quarto korrekt installiert ist, indem man ein Terminal öffnet und folgendes eingibt:

```sh
quarto --version
```

---

## Vorschau im Browser

Um eine Vorschau der Berichte im Browser anzuzeigen, öffnet man ein Terminal im Projektordner und gibt einen der folgenden Befehle ein:

```sh
# Vorschau des Publikumsberichts (Standardprofil, HTML-Website)
quarto preview

# Vorschau des Technischen Berichts (PDF)
quarto preview --profile technisch
```

Der Browser öffnet sich automatisch mit einer Vorschau. Änderungen an den Quelldateien werden dabei sofort angezeigt.

---

## Berichte erstellen (Rendern)

Um die fertigen Berichte zu erstellen, gibt man folgenden Befehl ins Terminal ein:

```sh
# Publikumsbericht als HTML-Website erstellen (Standardprofil)
quarto render

# Technischen Bericht als PDF erstellen
quarto render --profile technisch
```

Die erstellten Dateien landen anschliessend in den Ordnern:
- `_output-publikum/` (HTML-Website)
- `_output-technisch/` (PDF)

---

## Hinweis zu sensiblen Daten

Der Layer **`Amphibien_und_Reptilien`** wurde aus `data/Fundmeldungen.gpkg` entfernt und ist nicht Teil dieses Repositories. Es handelt sich um sensible Rohdaten (Ground-Truth-Daten) mit präzisen Fundkoordinaten, die nicht öffentlich zugänglich sein sollen.

Ein Backup des vollständigen `Fundmeldungen.gpkg` (inkl. diesem Layer) liegt verschlüsselt unter `data/Fundmeldungen.gpkg-backup.gpg`. Um daraus die bereinigte Version wiederherzustellen:

```sh
# 1. Backup entschlüsseln
gpg --output data/Fundmeldungen_full.gpkg --decrypt data/Fundmeldungen.gpkg-backup.gpg

# 2. Sensitiven Layer entfernen
ogrinfo data/Fundmeldungen_full.gpkg -sql "DROP TABLE \"Amphibien_und_Reptilien\""

# 3. Umbenennen
mv data/Fundmeldungen_full.gpkg data/Fundmeldungen.gpkg
```

---

## Veröffentlichen

Der Publikumsbericht wird auf [Netlify](https://www.netlify.com/) unter https://www.cesbiodiv.ch gehostet. Um eine neue Version zu veröffentlichen, gibt man folgenden Befehl ein (das Rendern erfolgt dabei automatisch):

```sh
quarto publish netlify
```

Hinweis: Das Veröffentlichen erfordert einen Netlify-Account und eine Bestätigung im Browser. Im Terminal muss beim Fragen nach dem Veröffentlichungsort die richtige Seite aus der Auswahlliste gewählt werden.
