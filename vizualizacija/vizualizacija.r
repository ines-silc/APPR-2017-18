# 3. faza: Vizualizacija podatkov

#Grafi
graf1 <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) 
graf1 <- graf1 + geom_bar(position="dodge", stat="identity", colour="black")
graf1 <- graf1 + labs(subtitle ="Odstotek dohodka za različne vrste izdatkov")
graf1 <- graf1 + scale_x_continuous(breaks=seq(2005,2014,1))
graf1 <- graf1 + scale_fill_brewer(palette = "Blues")

tabela21 <- uvozi.kazalnike() %>% fill(1:5)
stopnja <- gather(tabela21, "stopnja brezposelnosti", key = "vrsta", value = "meritev")
stopnja <- stopnja[, ! names(stopnja) %in% c("vrsta", "prebivalci na zdravnika",
                                             "delež obsojenih ljudi"), drop = F]
stopnja_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
stopnja_graf <- stopnja_graf + geom_bar(position="dodge", stat="identity", colour="black")
stopnja_graf <-  stopnja_graf + scale_x_continuous(breaks=seq(2005,2015,1))
stopnja_graf <- stopnja_graf + labs(title ="Stopnja brezposelnosti v Sloveniji po regijah")
stopnja_graf <- stopnja_graf + scale_fill_brewer(palette = "Paired")
stopnja_graf


pnz <- gather(tabela21, "prebivalci na zdravnika", key = "vrsta", value = "meritev")
pnz <- pnz[, ! names(pnz) %in% c("vrsta", "stopnja brezposelnosti",
                                 "delež obsojenih ljudi"), drop = F]
pnz_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
pnz_graf <- pnz_graf + geom_bar(position="dodge", stat="identity", colour="black")
pnz_graf <- pnz_graf + scale_x_continuous(breaks=seq(2005,2015,1))
pnz_graf <- pnz_graf + labs(title ="Število prebivalcev na enega zdravnika v Sloveniji po regijah")
pnz_graf <- pnz_graf + scale_fill_brewer(palette = "Paired")
pnz_graf


delez_obsojenih <- gather(tabela21, "delež obsojenih ljudi", key = "vrsta", value = "meritev")
delez_obsojenih <- delez_obsojenih[, ! names(delez_obsojenih) %in% 
                                     c("stopnja brezposelnosti", "prebivalci na zdravnika",
                                       "vrsta"), drop = F]
delez_obsojenih_graf <- ggplot(data = stopnja, aes(x = leto, y = meritev, fill = regija))
delez_obsojenih_graf <- delez_obsojenih_graf + geom_bar(position="dodge", stat="identity", colour="black")
delez_obsojenih_graf <- delez_obsojenih_graf + scale_x_continuous(breaks=seq(2005,2015,1))
delez_obsojenih_graf <- delez_obsojenih_graf + labs(title ="Delež obsojenih ljudi v Sloveniji po regijah")
delez_obsojenih_graf <- delez_obsojenih_graf + scale_fill_brewer(palette = "Paired")
delez_obsojenih_graf

#vrsta_urejeno <- structure(c("Moški", "Ženske", "Zdrava leta pri rojstvu Ženske", "Zdrava leta Ženske",
                             #"Zdrava leta pri rojstvu Moški", "Zdrava leta Moški"))
graf3 <- ggplot(tabela3, aes(x=leto, y=meritev, fill = Vrsta)) 
graf3 <- graf3 + geom_bar(stat="identity",  position=position_dodge(), colour="black")
graf3 <- graf3 + scale_x_continuous(breaks=seq(2005,2015,1))
graf3 <- graf3 + labs(title = "Primerjava življenjske dobe in zdravih let")
graf3 <- graf3 + scale_fill_brewer(palette = "Dark2")
graf3

tabela41 <- uvozi.naravne.vire() %>% fill(1)
poraba_vode <- tabela41[, ! names(tabela41) %in% c("odpadki", "st_avtomobilov"), drop = F]
poraba_vode_graf <- ggplot(data = poraba_vode, aes(x = leto, y = poraba_vode, fill = regija))
poraba_vode_graf <- poraba_vode_graf + geom_bar(position="dodge", stat="identity", colour="black")
poraba_vode_graf <- poraba_vode_graf + scale_x_continuous(breaks=seq(2005,2015,1))
poraba_vode_graf <- poraba_vode_graf + labs(title = "Poraba vode v Sloveniji po regijah")
poraba_vode_graf <- poraba_vode_graf + scale_fill_brewer(palette = "Paired")
poraba_vode_graf


odpadki <- tabela41[, ! names(tabela41) %in% c("poraba_vode", "st_avtomobilov"), drop = F]
odpadki_graf <- ggplot(data = odpadki, aes(x = leto, y = odpadki, fill = regija))
odpadki_graf <- odpadki_graf + geom_bar(position="dodge", stat="identity", colour="black")
odpadki_graf <- odpadki_graf + scale_x_continuous(breaks=seq(2005,2015,1))
odpadki_graf <- odpadki_graf + labs(title = "Odpadki v Sloveniji po regijah")
odpadki_graf <- odpadki_graf + scale_fill_brewer(palette = "Paired")
odpadki_graf


avtomobili <- tabela41[, ! names(tabela41) %in% c("odpadki", "poraba_vode"), drop = F]
avtomobili_graf <- ggplot(data = avtomobili, aes(x = leto, y = st_avtomobilov, fill = regija))
avtomobili_graf <- avtomobili_graf + geom_bar(position="dodge", stat="identity", colour="black")
avtomobili_graf <- avtomobili_graf + scale_x_continuous(breaks=seq(2005,2015,1))
avtomobili_graf <- avtomobili_graf + labs(title = "Število avtomobilov na 1000 prebivalcev v Sloveniji po regijah")
avtomobili_graf <- avtomobili_graf + scale_fill_brewer(palette = "Paired")
avtomobili_graf

# Uvozimo zemljevid.
gpclibPermit()
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm_shp/SVN_adm1.shp",
                             encoding = "UTF-8") %>% pretvori.zemljevid()
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  #{ gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)
####

zemljevid <- readShapeSpatial("C:/Users/Ines Šilc/Downloads/SVN_adm_shp/SVN_adm1", 
                              proj4string=CRS(as.character(NA)), 
                              verbose=FALSE, repair=FALSE, IDvar=NULL, force_ring=FALSE, 
                              delete_null_obj=FALSE, retrieve_ABS_null=FALSE)
class(zemljevid)
plot(zemljevid)
#regije1 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
           #"Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Goriška", "Obalno-kraška")
#regije2 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
             #"Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Posavska")
