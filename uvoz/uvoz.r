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
  data <- read_csv2("C:/Users/Ines Šilc/Documents/APPR-2017-18/podatki/Ekonomska_rast.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Ekonomska_rast.csv", 
                    col_names = c("leto", "rast (index 1995)", "dohodek"),
                    locale = locale(encoding = "Windows-1250"), skip = 3, n_max = 11, na = "...")
  return(data)
}

uvozi.izdatke <- function() {
  data <- read_csv2("C:/Users/Ines Šilc/Documents/APPR-2017-18/podatki/Socialna_zascita.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Socialna_zascita.csv",
                    col_names = c("leto", "izdatki za bolezen", "izdatki za invalidnost", "izdatki za starost", 
                                  "izdatki za smrt hranitelja družine", "Izdatki za družino in otroke", "Izdatki za brezposelnost",
                                  "Izdatki za nastanitev", "drugo"), 
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 10, na = "...")
  return(data)
  }
tabela1 <- inner_join(uvozi.bdp(), uvozi.izdatke(), by = "leto" )


uvozi.kazalnike <- function(){
  data <- read_csv2("C:/Users/Ines Šilc/Documents/APPR-2017-18/podatki/Kazalniki_varnosti.csv",
  #data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Kazalniki_varnosti.csv", 
                    col_names = c("leto", "regija", "stopnja brezposelnosti",
                                  "prebivalci na zdravnika", "delež obsojenih ljudi"),
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 132, na = "...")
  return(data)
}
library(tidyr)
tabela2 <- uvozi.kazalnike() %>% fill(1:5)



uvozi.zdrava.leta <- function(){
  data <- read_csv("C:/Users/Ines Šilc/Documents/APPR-2017-18/podatki/zdrava_leta.csv",
                    col_names = c("leto", "Zdrava leta pri rojstvu Ženske", "Zdrava leta Ženske",
                                  "Zdrava leta pri rojstvi Moški", "Zdrava leta Moški"), 
                    locale = locale(encoding = "Windows-1250"), skip = 10, n_max = 11)
  return(data)
}
zdrava.leta <- uvozi.zdrava.leta()

uvozi.naravne.vire <- function(){
  data <- read_csv2("C:/Users/Ines Šilc/Documents/APPR-2017-18/podatki/naravni_viri.csv",
                    col_names = c("leto", "regija", "poraba vode", "odpadki", "št. avtomobilov/1000"), 
                    locale = locale(encoding = "UTF-8"), skip = 3, n_max = 143)
  return(data)
}
tabela4 <- uvozi.naravne.vire() %>% fill(1)

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih fazah
