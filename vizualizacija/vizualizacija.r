# 3. faza: Vizualizacija podatkov

graf.bdp <- ggplot(data = bdp) +
            geom_point(aes(x = dohodek, y = rast))+ 
            labs(title ="Povezava med rastjo in velikostjo dohodka")+
            geom_text(aes(x = dohodek, y = rast, label=leto),hjust=0, vjust=0)+
            scale_y_continuous(limits = c(1250, 1700))+
            scale_x_continuous(limits = c(4300, 9000))+
            xlab("Dohodek") + ylab("Gospodarska rast")
            

graf.rast.doba <- ggplot(data = prva) +
              geom_point(aes(x = rast, y = st_let), stat = 'identity')+
              geom_smooth(aes(x = rast, y = st_let), method = lm)+
              geom_text(aes(x = rast, y = st_let, label=leto),hjust=0, vjust=0)+
              labs(title ="Povezava gospodarske rasti in življenjske dobe")+
              ylab("Življenjska doba") + xlab("Gospodarska rast")


graf.izdatki <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) +
         geom_bar(position="dodge", stat="identity", colour="black")+
          labs(title ="Odstotek dohodka za različne vrste izdatkov")+
          scale_x_continuous(breaks=seq(2005,2014,1))+
          scale_fill_brewer(palette = "Paired")


tortni.graf.izdatki <- ggplot(povprecje_izdatkov, aes(x = factor(1), y=meritev ,fill=factor(vrsta)) ) + 
                      geom_bar(width = 1,stat="identity")+
                      coord_polar(theta = "y") +
                      scale_fill_brewer(palette = "Paired")

graf.leta <- ggplot(tabela3, aes(x=leto, y=meritev, color = reorder(Vrsta, vrsta_urejeno[Vrsta]))) +
                    geom_line() + geom_point()+
                    scale_x_continuous(breaks=seq(2005,2015,1))+
                    labs(title = "Primerjava življenjske dobe in zdravih let")+
                    scale_fill_brewer(palette = "Dark2", name = "Vrsta")


# Uvozimo zemljevid.
gpclibPermit()
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8") %>% pretvori.zemljevid()
levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska")] <- c("Primorsko-notranjska",
                                                      "Posavska")


zemljevid.stopnje <- ggplot() +
  geom_polygon(data = stopnja %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
                xlab("") + ylab("") + ggtitle("Povprečna stopnja brezposelnosti po regijah")



zemljevid.zdravniki <- ggplot() +
  geom_polygon(data = pnz %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
  xlab("") + ylab("") + ggtitle("Povprečna število prebivalcev na enega zdravnika")

zemljevid.obsojenih <- ggplot() +
  geom_polygon(data = delez_obsojenih %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =meritev), color = "black")+
  xlab("") + ylab("") + ggtitle("Povprečen delež obsojenih po regijah")


zemljevid.vode <- ggplot() +
  geom_polygon(data = voda %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poraba_vode), color = "black")+
               xlab("") + ylab("") + ggtitle("Poraba vode po regijah")
                #guides(fill = guide_colorbar(title = "m3/prebivalca"))


zemljevid.odpadki <- ggplot() +
  geom_polygon(data = odpadki1 %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = odpadki), color = "black")+
                xlab("") + ylab("") + ggtitle("Količina odpadkov po regijah")
                #guides(fill = guide_colorbar(title = "kilogram/prebivalca"))


zemljevid.avto <- ggplot() +
  geom_polygon(data = avto %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = avtomobili), color = "black")+
                xlab("") + ylab("") + ggtitle("Število avtomobilov na 1000 prebivalcev")

