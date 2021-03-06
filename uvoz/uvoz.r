sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

uvozi.zivljenjsko.dobo <- function() {
  link <- "https://sl.wikipedia.org/wiki/Pri%C4%8Dakovana_%C5%BEivljenjska_doba"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table")%>% .[[2]] %>% html_table(dec = ",")
  colnames(tabela) <- c("leto", "moski", "zenske", "neki", "leto1", "moski1", "zenske1")
  tabela1 <- select(tabela, leto, moski, zenske)
  tabela2 <- select(tabela, leto1, moski1, zenske1)
  colnames(tabela2) <- c("leto", "moski", "zenske")
  tabela <- merge(tabela1, tabela2, all = TRUE)
  tabela$leto <- parse_number(tabela$leto)
  tabela$moski <- parse_number(tabela$moski)
  tabela$zenske <- parse_number(tabela$zenske)
  return(tabela)
}
doba <- uvozi.zivljenjsko.dobo()
doba <- gather(doba, moski, zenske, key = "vrsta", value = "st_let")
doba <- arrange(doba, leto)
doba <- doba %>% group_by(leto) %>% summarise(st_let = mean(st_let))


uvozi.bdp <- function() {
  data <- read_csv2("podatki/Ekonomska_rast.csv",
                    col_names = c("leto", "rast", "dohodek"),
                    locale = locale(decimal_mark = ".", encoding = "Windows-1250"), skip = 3, n_max = 21, na = "...")
  data$rast <- parse_number(data$rast)
  data$rast <- data$rast/10
  return(data)
}
bdp <- uvozi.bdp()
prikaz.bdp <- uvozi.bdp()[6:20,]

prva <- inner_join(bdp, doba, by= "leto")



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
povprecje_izdatkov <- izdatki %>% group_by(vrsta) %>% summarise(meritev = mean(meritev))


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
tabela21 <- uvozi.kazalnike() %>% fill(1:5)
stopnja <- gather(tabela21, stopnja_brezposelnosti, key = "vrsta", value = "meritev")
stopnja <- stopnja[, ! names(stopnja) %in% c("vrsta", "prebivalci_na_zdravnika",
                                             "delez_obsojenih_ljudi"), drop = F]

povprecna_stopnja <- stopnja %>% group_by(regija) %>% summarise(Meritev = mean(meritev))
pnz <- gather(tabela21, prebivalci_na_zdravnika, key = "vrsta", value = "meritev")
pnz <- pnz[, ! names(pnz) %in% c("vrsta", "stopnja_brezposelnosti",
                                 "delez_obsojenih_ljudi"), drop = F]

povprecno_pnz <- pnz %>% group_by(regija) %>% summarise(meritev = mean(meritev))
names(povprecno_pnz) <- c("regija", "Meritev")
delez_obsojenih <- gather(tabela21, delez_obsojenih_ljudi, key = "vrsta", value = "meritev")
delez_obsojenih <- delez_obsojenih[, ! names(delez_obsojenih) %in% 
                                     c("stopnja_brezposelnosti", "prebivalci_na_zdravnika",
                                       "vrsta"), drop = F]
povprecno_delez_obsojenih <- delez_obsojenih %>% group_by(regija) %>% summarise(meritev = mean(meritev))
names(povprecno_delez_obsojenih) <- c("regija", "Meritev")


uvozi.dobo <- function(){
  data <- read_csv2("podatki/Zivljenjska_doba.csv",
                   col_names = c("leto", "Moški", "Ženske"), 
                   locale = locale(encoding = "Windows-1250"), skip = 12, n_max = 11)
  data <- data[ , c(1, 3, 2)]
  return(data)
}

uvozi.zdrava.leta <- function(){
  data <- read_csv("podatki/zdrava_leta.csv",
                    col_names = c("leto", "Zdrava leta pri rojstvu ženske", "Zdrava leta ženske",
                                  "Zdrava leta pri rojstvu moški", "Zdrava leta moški"), 
                    locale = locale(encoding = "Windows-1250"), skip = 10, n_max = 11)
  return(data)
}

tabela3 <- inner_join(uvozi.dobo(), uvozi.zdrava.leta(), by="leto")
tabela3 <- gather(tabela3, `Moški`, `Ženske`, `Zdrava leta ženske`, `Zdrava leta moški`,
            key = "Vrsta", value = "meritev")
tabela3 <- arrange(tabela3, leto)
tabela31 <- inner_join(bdp, uvozi.zdrava.leta(), by="leto")
prikaz.tabela3 <- inner_join(uvozi.dobo(), uvozi.zdrava.leta(), by="leto")[,c(1, 2, 3, 5, 7)]


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
tabela41 <- uvozi.naravne.vire() %>% fill(1)
poraba_vode <- tabela41[, ! names(tabela41) %in% c("odpadki", "st_avtomobilov"), drop = F]
voda <- poraba_vode %>% group_by(regija) %>% summarise(poraba_vode = mean(poraba_vode))
names(voda) <- c("regija", "Meritev")
odpadki <- tabela41[, ! names(tabela41) %in% c("poraba_vode", "st_avtomobilov"), drop = F]
odpadki1 <- odpadki %>% group_by(regija) %>% summarise(odpadki=mean(odpadki))
names(odpadki1) <- c("regija", "Meritev")
avtomobili <- tabela41[, ! names(tabela41) %in% c("odpadki", "poraba_vode"), drop = F] 
avto <- avtomobili %>% group_by(regija) %>% summarise(avtomobili = mean(st_avtomobilov))
names(avto) <- c("regija", "Meritev")
