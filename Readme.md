
## Preprocessing:


1. Run import.R to create docx_df.csv
2. Run pandoc-convert.sh to create md files
3. Process md files manually and rename as qmd Files
4. Run fundmeldungen.R to create a Geopackage with all the Fundmeldungen
6. Render and Preview (see below)

## Preview


```sh
quarto preview --profile technisch
quarto preview --profile publikum
```


## Render


### HTML

```sh
quarto render --profile technisch
quarto render --profile publikum
```

## Publishing

(to publish, you dont have to render the project first. This is done automatically)

- Technischer Bericht is published 
  - https://ces-technischer-bericht.netlify.app/
  - Alias: ces-technischer-bericht.ratnaweera.xyz

- Publikumsbericht is published
  - https://ces-publikumsbericht.netlify.app/
  - Alias: ces-publikumsbericht.ratnaweera.xyz


To publish, theoretically you can run the following commands. However, 
it seems you need to omit the `--id` parameter and then choose the correct
location using the Dropdown in the terminal. 

Also, you need to approve every publication via the browser, by logging in first.

```sh
quarto publish netlify --profile publikum --id b439bbb0-bf5b-4748-89cf-709d69945e29

quarto publish netlify --profile technisch --id 7f330b56-ca33-4f86-90d8-162745e90e08
```