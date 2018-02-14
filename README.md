# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kazalcev trajnostnega razvoja in kakovost življenja v Sloveniji

V projektu bom analizirala kazalce družbene blaginje v Sloveniji s štirih področji. 

Prvo področje bo splošna ekonomska rast, tu se bom osredotočila predvsem na podatke o rasti bruto domačega proizvoda na prebivalca ter dohodek, pričakovana življenjska doba in izraba naravnih virov.

Drugo  področje je Varnost, tu so vključeni: 
* kazalniki socialne zaščite (kjer se merijo izdatki za starost, invalidnost, brezposelnost...) 
* stopnja brezposelnosti 
* število prebivalcev na enega zdravnika in 
* delež obsojenih oseb. 

Tretje področje je zdravje. Tu se bom osredotočila na podatke o procentu ljudi, ki živi v slabih stanovanjskih razmerah, število zdravih let ljudi pri rojstvu in kot procent cele življenjske dobe ter navedla podatke o nezadovoljstvu ljudi z slovenskim zdravstvenim sistemom (tu se bom osredotočila predvsem na podatke, ki so dostopni na Eurostatu, pod podatki zakaj ljudje niso prišli do želenega zdravljenja).

V zadnjem področju bom raziskovala porabo vode, odpadkov in avtomobilov po regijah.

Cilj: poskušala bom najti povezave med gospodarsko rastjo in izdatki za zdravstvo in povezave med brezposelnostjo in številom obsojenih ljudi ter dostopom do zdravstvene oskrbe v Sloveniji.

Za vir podatkov bom uporabljala Statistični urad republike Slovenije (dostopno na povezavi: http://pxweb.stat.si/pxweb/Database/Okolje/Okolje.asp v obliki .csv), Eurostat (http://ec.europa.eu/eurostat/data/database v obliki .csv) in Wikipedijo (https://sl.wikipedia.org/wiki/Pri%C4%8Dakovana_%C5%BEivljenjska_doba v obliki .html)

## Podatki v tabelah

1. `BDP` - Podatki o bruto domačem proizvodu in gospodarski rasti:
 - `Leto` -spremenljivka: leto, katerega so bile narejene meritve
 - `Bruto domači proizvod` - meritev: rast bruto domačega proizvoda (število)
 - `Dohodek` - meritev: povprečni dohodek na člana gospodinjstva (število)

2. `Izdatki` - podatki o posameznih delih dohodka:
 - `Leto` - spremenljivka: leto, katerega so bile narejene meritve
 - `Izdatki za zdravstveno varstvo` - meritev: delež dohodka, ki se nameni za zdravstveno varstvo
 - `Izdatki za invalidnost` - meritev: delež dohodka, ki se nameni za invalidnost
 - `Izdatki za smrt hranitelja` - meritev: delež dohodka, ki se nameni za smrt hranitelja
 - `Izdatki za starost` - meritev: delež dohodka, ki se nameni za starost
 - `Izdatki za družino` - meritev: delež dohodka, ki se nameni za družino
 - `Izdatki za brezposelnost` - meritev: delež dohodka, ki se nameni za brezposelnost
 - `Izdatki za nastanitev` - meritev: delež dohodka, ki se nameni za nastanitev

3. `Družbeni kazalniki` -podatki o družbenih kazalnikih po regijah:
 - `Leto` - spremenljivka: leto, katerega so bile narejene meritve
 - `regija` - spremenljivka: regija, v kateri so bile narejene meritve
 - `Brezposelnost` - meritev: povprečna stopnja brezposelnosti
 - `Število prebivalcev na enega zdravnika` - meritev: število prebivalcev na enega zdravnika
 - `Delež obsojenih ljudi` - meritev: delež obsojenih oseb med prebivalci regije po regiji            stalnega prebivališča
 
4. `Življenjska doba` - podatki o zdravih letih in letih na splošno:
 - `Leto` - spremenljivka: leto, katerega so bile narejene meritve
 - `Življenjska doba ženske` - meritev: povprečna življenjska doba ženske
 - `Življenjska doba moški` - meritev: povprečna življenjska moških
 - `Število zdravih let žensk` - meritev: pričakovano število zdravih let žensk skozi celotno         življenje
 - `Število zdravih let moških` - meritev: pričakovano število zdravih let moških skozi celotno       življenje

5. `Okoljski kazatelji` - podatki o okoljskih kazateljih po regijah:
 - `Leto`- spremenljivka: leto, katerega so bile narejene meritve
 - `Regija`- spremenljivka: regija, v kateri so bile narejene meritve
 - `Poraba vode, dobavljene iz javnega vodovoda` - meritev: Poraba vode, dobavljene iz javnega       vodovoda, v gospodinjstvih na prebivalca (m3/prebivalca)
 - `Komunalni odpadki` - meritev: Komunalni odpadki, zbrani z javnim odvozom odpadkov na            prebivalca (kilogram/prebivalca)
 - `Število vseh osebnih avtomobilov na 1.000 prebivalcev` - meritev: Število vseh osebnih         avtomobilov na 1.000 prebivalcev (število/1.000 prebivalcev)

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
