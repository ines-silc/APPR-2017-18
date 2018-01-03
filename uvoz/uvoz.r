sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

uvozi.bdp <- function() {
  data <- read_csv2("podatki/Ekonomska_rast.csv",
                    col_names = c("leto", "rast", "dohodek"),
                    locale = locale(decimal_mark = ".", encoding = "Windows-1250"), skip = 3, n_max = 11, na = "...")
  data$rast <- parse_number(data$rast)
  return(data)
}

uvozi.izdatke <- function() {
  data <- read_csv2("podatki/Socialna_zascita.csv",
                    col_names = c("leto", "izdatki za bolezen", "izdatki za invalidnost", "izdatki za starost", 
                                  "izdatki za smrt hranitelja družine", "Izdatki za družino in otroke", 
                                  "Izdatki za brezposelnost", "Izdatki za nastanitev", "drugo"), 
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 10, na = "...")
  data$"izdatki za bolezen" <- parse_number(data$"izdatki za bolezen")
  return(data)
}
izdatki <- uvozi.izdatke()
izdatki <- gather(izdatki, "izdatki za bolezen", "izdatki za invalidnost", "izdatki za starost", 
                  "izdatki za smrt hranitelja družine", "Izdatki za družino in otroke", 
                  "Izdatki za brezposelnost", "Izdatki za nastanitev", "drugo", key = "vrsta", value = "meritev")
izdatki <- arrange(izdatki, leto)

tabela1 <- inner_join(uvozi.bdp(), uvozi.izdatke(), by = "leto" )
tabela1 <- gather(tabela1, "rast", "dohodek", "izdatki za bolezen", "izdatki za invalidnost",
                  "izdatki za starost", "izdatki za smrt hranitelja družine", "Izdatki za družino in otroke",
                  "Izdatki za brezposelnost", "Izdatki za nastanitev", "drugo", key = "vrsta", value = "meritev")
tabela1 <- arrange(tabela1, leto)

uvozi.kazalnike <- function(){
  data <- read_csv2("podatki/Kazalniki_varnosti.csv",
                    col_names = c("leto", "regija", "stopnja brezposelnosti",
                                  "prebivalci na zdravnika", "delež obsojenih ljudi"),
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 132, na = "...")
  return(data)
}

tabela2 <- uvozi.kazalnike() %>% fill(1:5)
tabela2 <- gather(tabela2, "stopnja brezposelnosti",
                  "prebivalci na zdravnika", "delež obsojenih ljudi", 
                  key = "vrsta", value = "meritev")
tabela2 <- arrange(tabela2, leto)

uvozi.dobo <- function(){
  data <- read_csv2("podatki/Zivljenjska_doba.csv",
                   col_names = c("leto", "Moški", "Ženske"), 
                   locale = locale(encoding = "Windows-1250"), skip = 12, n_max = 11)
  data <- data[ , c(1, 3, 2)]
  return(data)
}

uvozi.zdrava.leta <- function(){
  data <- read_csv("podatki/zdrava_leta.csv",
                    col_names = c("leto", "Zdrava leta pri rojstvu Ženske", "Zdrava leta Ženske",
                                  "Zdrava leta pri rojstvu Moški", "Zdrava leta Moški"), 
                    locale = locale(encoding = "Windows-1250"), skip = 10, n_max = 11)
  return(data)
}

tabela3 <- inner_join(uvozi.dobo(), uvozi.zdrava.leta(), by="leto")
tabela3 <- gather(tabela3, `Moški`, `Ženske`, `Zdrava leta pri rojstvu Ženske`, `Zdrava leta Ženske`,
            `Zdrava leta pri rojstvu Moški`, `Zdrava leta Moški`,
            key = "Vrsta", value = "meritev")
tabela3 <- arrange(tabela3, leto)

uvozi.naravne.vire <- function(){
  data <- read_csv2("podatki/naravni_viri.csv",
                    col_names = c("leto", "regija", "poraba_vode", "odpadki", "st_avtomobilov"), 
                    locale = locale(encoding = "UTF-8"), skip = 3, n_max = 132)
  return(data)
}

tabela4 <- uvozi.naravne.vire() %>% fill(1)
tabela4 <- gather(tabela4, `poraba_vode`, `odpadki`, `st_avtomobilov`, 
                  key = "Vrsta", value = "meritev")
tabela4 <- arrange(tabela4, leto)