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

graf1 <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) 
graf1 + geom_bar(position="dodge", stat="identity", colour="black")
#graf1 + scale_x_continuous(breaks=seq(2005,2014,1))
#graf1 + expand_limits(x=c(2004,2015), y=c(0, 50))

uvozi.kazalnike <- function(){
  data <- read_csv2("podatki/Kazalniki_varnosti.csv",
                    col_names = c("leto", "regija", "stopnja brezposelnosti",
                                  "prebivalci na zdravnika", "delež obsojenih ljudi"),
                    locale = locale(encoding = "Windows-1250"), skip = 2, n_max = 132, na = "...")
  return(data)
}

tabela2 <- uvozi.kazalnike() %>% fill(1:5)

stopnja <- gather(tabela2, "stopnja brezposelnosti", key = "vrsta", value = "meritev")
stopnja <- stopnja[, ! names(stopnja) %in% c("vrsta", "prebivalci na zdravnika",
                                             "delež obsojenih ljudi"), drop = F]
stopnja_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
stopnja_graf + geom_bar(position="dodge", stat="identity", colour="black")
#stopnja_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#stopnja_graf + labs(title ="Stopnja brezposelnosti v Sloveniji po regijah")

pnz <- gather(tabela2, "prebivalci na zdravnika", key = "vrsta", value = "meritev")
pnz <- pnz[, ! names(pnz) %in% c("vrsta", "stopnja brezposelnosti",
                                         "delež obsojenih ljudi"), drop = F]
pnz_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
pnz_graf + geom_bar(position="dodge", stat="identity", colour="black")
#pnz_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#pnz_graf + labs(title ="Število prebivalcev na enega zdravnika v Sloveniji po regijah")

delez_obsojenih <- gather(tabela2, "delež obsojenih ljudi", key = "vrsta", value = "meritev")
delez_obsojenih <- delez_obsojenih[, ! names(delez_obsojenih) %in% 
                                     c("stopnja brezposelnosti", "prebivalci na zdravnika",
                                                     "vrsta"), drop = F]
delez_obsojenih_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
delez_obsojenih_graf + geom_bar(position="dodge", stat="identity", colour="black")
#delez_obsojenih_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#delez_obsojenih_graf + labs(title ="Delež obsojenih ljudi v Sloveniji po regijah")

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

graf3 <- ggplot(data=tabela3, aes(x=leto, y=meritev, fill = Vrsta)) 
graf3 + geom_bar(stat="identity",  position=position_dodge(), colour="black")
#graf3 + scale_x_continuous(breaks=seq(2005,2014,1))
#graf3 + labs(title = "Primerjava življenjske dobe in zdravih let")

uvozi.naravne.vire <- function(){
  data <- read_csv2("podatki/naravni_viri.csv",
                    col_names = c("leto", "regija", "poraba_vode", "odpadki", "st_avtomobilov"), 
                    locale = locale(encoding = "UTF-8"), skip = 3, n_max = 132)
  return(data)
}
tabela5 <- uvozi.naravne.vire() %>% fill(1)
tabela4 <- uvozi.naravne.vire() %>% fill(1)
tabela4 <- gather(tabela4, `poraba_vode`, `odpadki`, `st_avtomobilov`, 
                  key = "Vrsta", value = "meritev")
tabela4 <- arrange(tabela4, leto)

poraba_vode <- tabela5[, ! names(tabela5) %in% c("odpadki", "st_avtomobilov"), drop = F]
poraba_vode_graf <- ggplot(data = poraba_vode, aes(x = leto, y = poraba_vode, fill = regija))
poraba_vode_graf + geom_bar(position="dodge", stat="identity", colour="black")
#poraba_vode_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#poraba_vode_graf + labs(title = "Poraba vode v Sloveniji po regijah")

odpadki <- tabela5[, ! names(tabela5) %in% c("poraba_vode", "st_avtomobilov"), drop = F]
#odpadki %>% drop_na(odpadki)
odpadki_graf <- ggplot(data = odpadki, aes(x = leto, y = odpadki, fill = regija))
odpadki_graf + geom_bar(position="dodge", stat="identity", colour="black")
#odpadki_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#odpadki_graf + labs(title = "Odpadki v Sloveniji po regijah")

avtomobili <- tabela5[, ! names(tabela5) %in% c("odpadki", "poraba_vode"), drop = F]
#avtomobili %>% drop_na(avtomobili)
avtomobili_graf <- ggplot(data = avtomobili, aes(x = leto, y = st_avtomobilov, fill = regija))
avtomobili_graf + geom_bar(position="dodge", stat="identity", colour="black")
#avtomobili_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#avtomobili_graf + labs(title = "Število avtomobilov na 1000 prebivalcev v Sloveniji po regijah")