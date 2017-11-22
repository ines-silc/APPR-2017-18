# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kazalcev trajnostnega razvoja in kakovost življenja v Sloveniji

V projektu bom analizirala kazalce družbene blaginje v Sloveniji s treh področji. 

Prvo področje bo splošna ekonomska rast, tu se bom osredotočila predvsem na podatke o rasti bruto domačega proizvoda na prebivalca ter dohodek, pričakovana življenjska doba in izraba naravnih virov.

Drugo  področje je Varnost, tu so vključeni: 
* kazalniki socialne zaščite (kjer se merijo izdatki za starost, invalidnost, brezposelnost...) 
* stopnja brezposelnosti 
* število prebivalcev na enega zdravnika in 
* delež obsojenih oseb. 

Tretje področje pa je zdravje. Tu se bom osredotočila na podatke o procentu ljudi, ki živi v slabih stanovanjskih razmerah, število zdravih let ljudi pri rojstvu in kot procent cele življenjske dobe ter navedla podatke o nezadovoljstvu ljudi z slovenskim zdravstvenim sistemom (tu se bom osredotočila predvsem na podatke, ki so dostopni na Eurostatu, pod podatki zakaj ljudje niso prišli do želenega zdravljenja).

Cilj: poskušala bom najti povezave med gospodarsko rastjo in izdatkov za zdravstvo in povezave med brezposelnostjo in številom obsojenih ljudi ter dostopom do zdravstvene oskrbe v Sloveniji.

Za vir podatkov bom uporabljala Statistični urad republike Slovenije (dostopno na povezavi: http://pxweb.stat.si/pxweb/Database/Okolje/Okolje.asp v obliki .csv), Eurostat (http://ec.europa.eu/eurostat/data/database v obliki .csv) in Wikipedijo (https://sl.wikipedia.org/wiki/Pri%C4%8Dakovana_%C5%BEivljenjska_doba v obliki .html)

## Podatki v tabelah

*Tabela 1* bo prikazovala v obdobju 2000-2014 podatke o:
* Bruto domačem proizvodu
* Dohodku
* Izdatkih za zdravstveno varstvo
* Izdatkih za invalidnost
* Izdatkih za smrt hranitelja
* Izdatkih za starost
* Izdatkih za družino
* Izdatkih za brezposelnost
* Izdatkih za nastanitev

*Tabela 2* bo prikazovala regijske podatke o:
* Brezposelnosti
* Številu prebivalcev na enega zdravnika
* Deležu obsojenih ljudi

*Tabela 3* bo prikazovala v obdobju 2005-2015 ločeno po spolih podatke o:
* Življenjski dobi
* Številu zdravih let

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
