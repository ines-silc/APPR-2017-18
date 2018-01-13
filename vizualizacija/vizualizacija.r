# 3. faza: Vizualizacija podatkov

#Grafi
bdp <- uvozi.bdp()
graf.bdp <- ggplot(data = bdp, aes(x = dohodek, y = rast)) +
            geom_point(stat = 'identity')+ 
            labs(title ="Povezava med rastjo in velikostjo dohodka")


graf1 <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) 
graf1 <- graf1 + geom_bar(position="dodge", stat="identity", colour="black")
graf1 <- graf1 + labs(title ="Odstotek dohodka za različne vrste izdatkov")
graf1 <- graf1 + scale_x_continuous(breaks=seq(2005,2014,1))
graf1 <- graf1 + scale_fill_brewer(palette = "Blues")

vrsta_urejeno <- c("Ženske" = 1,
                   "Moški" = 2,
                   "Zdrava leta pri rojstvu Ženske" = 3,
                   "Zdrava leta Ženske" = 4,
                   "Zdrava leta pri rojstvu Moški" = 5,
                   "Zdrava leta Moški" = 6)
graf3 <- ggplot(tabela3, aes(x=leto, y=meritev, color = reorder(Vrsta, vrsta_urejeno[Vrsta]))) 
graf3 <- graf3 + geom_line() + geom_point()
graf3 <- graf3 + scale_x_continuous(breaks=seq(2005,2015,1))
graf3 <- graf3 + labs(title = "Primerjava življenjske dobe in zdravih let")
graf3 <- graf3 + scale_fill_brewer(palette = "Dark2")

# Uvozimo zemljevid.
gpclibPermit()
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8") %>% pretvori.zemljevid()
levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska")] <- c("Primorsko-notranjska",
                                                      "Posavska")
tabela21 <- uvozi.kazalnike() %>% fill(1:5)
stopnja <- gather(tabela21, stopnja_brezposelnosti, key = "vrsta", value = "meritev")
stopnja <- stopnja[, ! names(stopnja) %in% c("vrsta", "prebivalci_na_zdravnika",
                                             "delez_obsojenih_ljudi"), drop = F]
povprecna_stopnja <- stopnja %>% group_by(regija) %>% summarise(meritev = mean(meritev))
zemljevid.stopnje <- ggplot() +
  geom_polygon(data = stopnja %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
                xlab("") + ylab("") + ggtitle("Povprečna stopnja brezposelnosti po regijah")


pnz <- gather(tabela21, prebivalci_na_zdravnika, key = "vrsta", value = "meritev")
pnz <- pnz[, ! names(pnz) %in% c("vrsta", "stopnja_brezposelnosti",
                                 "delez_obsojenih_ljudi"), drop = F]
povprecno_pnz <- pnz %>% group_by(regija) %>% summarise(meritev = mean(meritev))
zemljevid.zdravniki <- ggplot() +
  geom_polygon(data = pnz %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
  xlab("") + ylab("") + ggtitle("Povprečna število prebivalcev na enega zdravnika")

delez_obsojenih <- gather(tabela21, delez_obsojenih_ljudi, key = "vrsta", value = "meritev")
delez_obsojenih <- delez_obsojenih[, ! names(delez_obsojenih) %in% 
                                     c("stopnja_brezposelnosti", "prebivalci_na_zdravnika",
                                       "vrsta"), drop = F]
povprecno_delez_obsojenih <- delez_obsojenih %>% group_by(regija) %>% summarise(meritev = mean(meritev))
zemljevid.obsojenih <- ggplot() +
  geom_polygon(data = delez_obsojenih %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
  xlab("") + ylab("") + ggtitle("Povprečen delež obsojenih po regijah")


tabela41 <- uvozi.naravne.vire() %>% fill(1)
poraba_vode <- tabela41[, ! names(tabela41) %in% c("odpadki", "st_avtomobilov"), drop = F]
voda <- poraba_vode %>% group_by(regija) %>% summarise(poraba_vode = mean(poraba_vode))
zemljevid.vode <- ggplot() +
  geom_polygon(data = voda %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poraba_vode), color = "black")+
               xlab("") + ylab("") + ggtitle("Poraba vode po regijah")
                #guides(fill = guide_colorbar(title = "m3/prebivalca"))


odpadki <- tabela41[, ! names(tabela41) %in% c("poraba_vode", "st_avtomobilov"), drop = F]
odpadki1 <- odpadki %>% group_by(regija) %>% summarise(odpadki=mean(odpadki))
zemljevid.odpadki <- ggplot() +
  geom_polygon(data = odpadki1 %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = odpadki), color = "black")+
                xlab("") + ylab("") + ggtitle("Količina odpadkov po regijah")
                #guides(fill = guide_colorbar(title = "kilogram/prebivalca"))


avtomobili <- tabela41[, ! names(tabela41) %in% c("odpadki", "poraba_vode"), drop = F] 
avto <- avtomobili %>% group_by(regija) %>% summarise(avtomobili = mean(st_avtomobilov))
zemljevid.avto <- ggplot() +
  geom_polygon(data = avto %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = avtomobili), color = "black")+
                xlab("") + ylab("") + ggtitle("Število avtomobilov na 1000 prebivalcev")

