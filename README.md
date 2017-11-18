# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kazalcev trajnostnega razvoja v Sloveniji: Varnost, ekonomska rast in kakovost naravnih virov

V projektu bom analizirala kazalce družbene blaginje v Sloveniji s treh področji. Prvo področje je Varnost, tu so vključeni: kazalniki socialne zaščite (kjer se merijo izdatki za starost, invalidnost, brezposelnost...), stopnja brezposelnosti, število prebivalcev na enega zdravnika in delež obsojenih oseb. Drugo področje bo ekonomska rast, tu se bom osredotočila predvsem na podatke o rasti bruto domačega proizvoda na prebivalca ter dohodek. Tretje področje pa je kakovost naravnih virov kot so: zrak, pitna voda in delež ekološkega kmetijstva. 

Za vir podatkov bom uporabljala Statistični urad republike Slovenije

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
