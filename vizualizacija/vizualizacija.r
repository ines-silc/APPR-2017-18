# 3. faza: Vizualizacija podatkov

graf.bdp <- ggplot(data = bdp) +
            geom_point(aes(x = dohodek, y = rast), color = "blue")+ 
            labs(title ="Povezava med rastjo in velikostjo dohodka")+
            geom_text(aes(x = dohodek, y = rast, label=leto),
                      hjust = 0, vjust = -0.3)+
            scale_y_continuous(limits = c(130, 170))+
            scale_x_continuous(limits = c(4700, 8900))+
            xlab("Dohodek") + ylab("Gospodarska rast")
     

graf.rast.doba <- ggplot(data = prva) +
              geom_point(aes(x = rast, y = st_let), stat = 'identity')+
              geom_smooth(aes(x = rast, y = st_let), method = lm)+
              geom_text(aes(x = rast, y = st_let, label=leto),hjust=0, vjust=-0.3)+
              labs(title ="Povezava gospodarske rasti in življenjske dobe")+
              ylab("Življenjska doba") + xlab("Gospodarska rast")


graf.izdatki <- ggplot(data = izdatki, aes(x=leto, y=meritev, fill = vrsta)) +
         geom_bar(position="dodge", stat="identity", colour="black")+
          labs(title ="Odstotek dohodka za različne vrste izdatkov")+
          scale_x_continuous(breaks=seq(2005,2014,1))+
          scale_fill_brewer(name = "Vrsta izdatkov", 
                            labels = c("Drugo", "Izdatki za bolezen",
                            "Izdatki za brezposelnost", "Izdatki za družino in otroke",
                            "Izdatki za invalidnost", "Izdatki za nastanitev", 
                            "Izdatki za smrt hranitelja družine", "Izdatki za starost"),
                            palette = "Paired") +
          ylab("Delež dohodka za različne izdatke (v %)")+xlab("Leto")


graf.leta <- ggplot(tabela3) +
                    geom_line(aes(x=leto, y=meritev, color = Vrsta)) + 
                    geom_point(aes(x=leto, y=meritev, color = Vrsta))+
                    scale_x_continuous(breaks=seq(2005,2015,1))+
                    labs(title = "Primerjava celotne življenjske dobe in zdravih let")+
                    scale_fill_brewer(palette = "Paired", name = "Vrsta dobe")+
                    ylab("Število let")+xlab("Leto")




#Primerjava številov avtomobilov in količini odpadkov
graf.avto.odpadki <- ggplot(data = left_join(odpadki1, avto)) +
  geom_point(aes(x = avtomobili, y = odpadki), stat = 'identity')+
  geom_text(aes(x = avtomobili, y = odpadki, label=regija),hjust=0, vjust=0)+
  labs(title ="Primerjava številov avtomobilov in količini odpadkov")+
  xlab("Število avtomobilov") + ylab("Količina odpadkov")


graf.brezp.obsojeni <- ggplot(data = left_join(povprecna_stopnja, povprecno_delez_obsojenih)) +
  geom_point(aes(x = Meritev, y = meritev), stat = 'identity')+
  geom_text(aes(x = Meritev, y = meritev, label=regija),hjust=0, vjust=0)+
  labs(title ="Primerjava povprečne stopnje brezposelnosti in deleža obsojenih ljudi")+
  ylab("Povprečen delež obsojenih") + xlab("Povprečna stopnja brezposelnosti")



# Uvozimo zemljevid.
gpclibPermit()
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8") %>% pretvori.zemljevid()
levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska")] <- c("Primorsko-notranjska",
                                                      "Posavska")
imena.pokrajin <- aggregate(cbind(long, lat) ~ regija, data = (avto %>% right_join(zemljevid, by = c("regija" = "NAME_1"))), FUN=function(x)mean(range(x)))

zemljevid.stopnje <- ggplot() +
  geom_polygon(data = povprecna_stopnja %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
              aes(x = long, y = lat, group = group, fill =Meritev), color = "black")+
              xlab("") + ylab("")+ 
              geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija)) + 
              ggtitle("Povprečna stopnja brezposelnosti po regijah")


zemljevid.zdravniki <- ggplot() +
  geom_polygon(data = povprecno_pnz %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill =Meritev), color = "black")+
              xlab("") + ylab("") + 
              geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija))+ 
              ggtitle("Povprečna število prebivalcev na enega zdravnika")

zemljevid.obsojenih <- ggplot() +
  geom_polygon(data = povprecno_delez_obsojenih %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = Meritev), color = "black")+
              xlab("") + ylab("")+ 
              geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija)) + 
              ggtitle("Povprečen delež obsojenih po regijah")


zemljevid.vode <- ggplot() +
  geom_polygon(data = voda %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
              aes(x = long, y = lat, group = group, fill = Meritev), color = "black")+
              xlab("") + ylab("")+ 
              geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija)) + 
              ggtitle("Poraba vode po regijah", 
              subtitle = "Poraba vode, dobavljene iz javnega vodovoda, v gospodinjstvih na prebivalca (m3/prebivalca)")
                


zemljevid.odpadki <- ggplot() +
  geom_polygon(data = odpadki1 %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = Meritev), color = "black")+
                xlab("") + ylab("")+ 
                geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija)) + 
                ggtitle("Količina odpadkov po regijah", 
                subtitle = "Komunalni odpadki, zbrani z javnim odvozom odpadkov na prebivalca (kilogram/prebivalca)")


zemljevid.avto <- ggplot() +
                geom_polygon(data = avto %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
                aes(x = long, y = lat, group = group, fill = Meritev), color = "black")+
                xlab("") + ylab("")+ 
                geom_text(data=imena.pokrajin, aes(x =long, y=lat, label = regija))+ 
                ggtitle("Število avtomobilov", 
                subtitle = "Število vseh osebnih avtomobilov na 1.000 prebivalcev (število/1.000 prebivalcev)")

