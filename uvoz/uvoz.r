# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")
library(XML)
uvozi.doba <- function() {
  data <- read_html("file:///C:/Users/Ines%20%C5%A0ilc/Documents/APPR-2017-18/podatki/zivljenjska_doba.html")
  colnames(tabela) <- c("1", "2")
  return(tabela)
}
zivljenjska.doba <- uvozi.doba()

uvozi.bdp <- function() {
  data <- read_csv2("C:\Users\Ines Šilc\Documents\APPR-2017-18\podatki\Ekonomska_rast.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Ekonomska_rast.csv", 
                    col_names = c("leto", "rast (index 1995)", "dohodek"),
                    locale = locale(encoding = "Windows-1250"), skip = 3, n_max = 11, na = "...")
  return(data)
}

uvozi.izdatke <- function() {
  data <- read_csv2("C:\Users\Ines Šilc\Documents\APPR-2017-18\podatki\Socialna_zascita.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Socialna_zascita.csv",
                    col_names = c("leto", "izdatki za bolezen", "izdatki za invalidnost", "izdatki za starost", 
                                  "izdatki za smrt hranitelja družine", "Izdatki za družino in otroke", "Izdatki za brezposelnost",
                                  "Izdatki za nastanitev", "drugo"), 
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 10, na = "...")
  return(data)
  }
tabela1 <- inner_join(uvozi.bdp(), uvozi.izdatke(), by = "leto" )


uvozi.kazalnike <- function(){
  data <- read_csv2("C:\Users\Ines Šilc\Documents\APPR-2017-18\podatki\Kazalniki_varnosti.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Kazalniki_varnosti.csv", 
                    col_names = c("leto", "regija", "stopnja brezposelnosti",
                                  "št. prebivalcev na 1 zdravnika", "delež obsojenih ljudi"),
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 132, na = "...")
  
  return(data)
  }
tabela2 <- uvozi.kazalnike()



# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih fazah
