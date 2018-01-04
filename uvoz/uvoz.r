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
                    col_names = c("leto", "izdatki_za_bolezen", "izdatki_za_invalidnost", "izdatki_za_starost", 
                                  "izdatki_za_smrt_hranitelja_družine", "Izdatki_za_druzino_in_otroke", 
                                  "Izdatki_za_brezposelnost", "Izdatki_za_nastanitev", "drugo"), 
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 10, na = "...")
  return(data)
}
izdatki <- uvozi.izdatke()
izdatki <- gather(izdatki, izdatki_za_bolezen, izdatki_za_invalidnost, izdatki_za_starost, 
                  izdatki_za_smrt_hranitelja_družine, Izdatki_za_druzino_in_otroke, 
                  Izdatki_za_brezposelnost, Izdatki_za_nastanitev, drugo, key = "vrsta", value = "meritev")
izdatki <- arrange(izdatki, leto)

tabela1 <- inner_join(uvozi.bdp(), uvozi.izdatke(), by = "leto")
tabela1 <- gather(tabela1, rast, dohodek, izdatki_za_bolezen, izdatki_za_invalidnost, izdatki_za_starost, 
                  izdatki_za_smrt_hranitelja_družine, Izdatki_za_druzino_in_otroke, 
                  Izdatki_za_brezposelnost, Izdatki_za_nastanitev, drugo, key = "vrsta", value = "meritev")
tabela1 <- arrange(tabela1, leto)

uvozi.kazalnike <- function(){
  data <- read_csv2("podatki/Kazalniki_varnosti.csv",
                    col_names = c("leto", "regija", "stopnja_brezposelnosti",
                                  "prebivalci_na_zdravnika", "delez_obsojenih_ljudi"),
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 132, na = "...")
  return(data)
}

tabela2 <- uvozi.kazalnike() %>% fill(1:5)
tabela2 <- gather(tabela2, stopnja_brezposelnosti,
                  prebivalci_na_zdravnika, delez_obsojenih_ljudi, 
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
  data <- read_csv2("podatki/Naravni_viri.csv",
                    col_names = c("leto", "regija", "poraba_vode", "odpadki", "st_avtomobilov"), 
                    locale = locale(encoding = "UTF-8"), skip = 3, n_max = 132)
  return(data)
}

tabela4 <- uvozi.naravne.vire() %>% fill(1)
tabela4 <- gather(tabela4, `poraba_vode`, `odpadki`, `st_avtomobilov`, 
                  key = "Vrsta", value = "meritev")
tabela4 <- arrange(tabela4, leto)
