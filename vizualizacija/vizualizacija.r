# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                             #"OB/OB", encoding = "Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  #{ gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)
####

gpclibPermit()
zemljevid <- readShapeSpatial("C:/Users/Ines Šilc/Downloads/SVN_adm_shp/SVN_adm1.shp")
class(zemljevid)
plot(zemljevid)
regije1 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
           "Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Goriška", "Obalno-kraška")
regije2 <- c("Pomurska", "Podravska", "Koroška", "Savinjska", "Zasavska", "Jugovzhodna Slovenija",
             "Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Posavska")
