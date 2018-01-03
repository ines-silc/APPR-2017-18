# 3. faza: Vizualizacija podatkov

#Grafi
graf1 <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) 
graf1 + geom_bar(position="dodge", stat="identity", colour="black")
#graf1 + scale_x_continuous(breaks=seq(2005,2014,1))
#graf1 + expand_limits(x=c(2004,2015), y=c(0, 50))

tabela21 <- uvozi.kazalnike() %>% fill(1:5)
stopnja <- gather(tabela21, "stopnja brezposelnosti", key = "vrsta", value = "meritev")
stopnja <- stopnja[, ! names(stopnja) %in% c("vrsta", "prebivalci na zdravnika",
                                             "delež obsojenih ljudi"), drop = F]
stopnja_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
stopnja_graf + geom_bar(position="dodge", stat="identity", colour="black")
#stopnja_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#stopnja_graf + labs(title ="Stopnja brezposelnosti v Sloveniji po regijah")

pnz <- gather(tabela21, "prebivalci na zdravnika", key = "vrsta", value = "meritev")
pnz <- pnz[, ! names(pnz) %in% c("vrsta", "stopnja brezposelnosti",
                                 "delež obsojenih ljudi"), drop = F]
pnz_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
pnz_graf + geom_bar(position="dodge", stat="identity", colour="black")
#pnz_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#pnz_graf + labs(title ="Število prebivalcev na enega zdravnika v Sloveniji po regijah")

delez_obsojenih <- gather(tabela21, "delež obsojenih ljudi", key = "vrsta", value = "meritev")
delez_obsojenih <- delez_obsojenih[, ! names(delez_obsojenih) %in% 
                                     c("stopnja brezposelnosti", "prebivalci na zdravnika",
                                       "vrsta"), drop = F]
delez_obsojenih_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
delez_obsojenih_graf + geom_bar(position="dodge", stat="identity", colour="black")
#delez_obsojenih_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#delez_obsojenih_graf + labs(title ="Delež obsojenih ljudi v Sloveniji po regijah")

graf3 <- ggplot(data=tabela3, aes(x=leto, y=meritev, fill = Vrsta)) 
graf3 + geom_bar(stat="identity",  position=position_dodge(), colour="black")
#graf3 + scale_x_continuous(breaks=seq(2005,2014,1))
#graf3 + labs(title = "Primerjava življenjske dobe in zdravih let")

poraba_vode <- tabela41[, ! names(tabela41) %in% c("odpadki", "st_avtomobilov"), drop = F]
poraba_vode_graf <- ggplot(data = poraba_vode, aes(x = leto, y = poraba_vode, fill = regija))
poraba_vode_graf + geom_bar(position="dodge", stat="identity", colour="black")
#poraba_vode_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#poraba_vode_graf + labs(title = "Poraba vode v Sloveniji po regijah")

odpadki <- tabela41[, ! names(tabela41) %in% c("poraba_vode", "st_avtomobilov"), drop = F]
#odpadki %>% drop_na(odpadki)
odpadki_graf <- ggplot(data = odpadki, aes(x = leto, y = odpadki, fill = regija))
odpadki_graf + geom_bar(position="dodge", stat="identity", colour="black")
#odpadki_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#odpadki_graf + labs(title = "Odpadki v Sloveniji po regijah")

tabela41 <- uvozi.naravne.vire() %>% fill(1)
avtomobili <- tabela41[, ! names(tabela41) %in% c("odpadki", "poraba_vode"), drop = F]
#avtomobili %>% drop_na(avtomobili)
avtomobili_graf <- ggplot(data = avtomobili, aes(x = leto, y = st_avtomobilov, fill = regija))
avtomobili_graf + geom_bar(position="dodge", stat="identity", colour="black")
#avtomobili_graf + scale_x_continuous(breaks=seq(2005,2014,1))
#avtomobili_graf + labs(title = "Število avtomobilov na 1000 prebivalcev v Sloveniji po regijah")

# Uvozimo zemljevid.
gpclibPermit()
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "shp/SVN_adm_shp",
                             encoding = "UTF-8") %>% pretvori.zemljevid()
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  #{ gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)
####

#gpclibPermit()
#zemljevid <- readShapeSpatial("C:/Users/Ines Šilc/Downloads/SVN_adm_shp/SVN_adm1.shp")
#class(zemljevid)
#plot(zemljevid)
#regije1 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
           #"Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Goriška", "Obalno-kraška")
#regije2 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
             #"Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Posavska")
