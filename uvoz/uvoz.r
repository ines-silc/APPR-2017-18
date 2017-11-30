# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

# Funkcija, ki uvozi občine iz Wikipedije
#uvozi.doba <- function() {
  #link <- "https://sl.wikipedia.org/wiki/Pri%C4%8Dakovana_%C5%BEivljenjska_doba"
  #stran <- html_session(link) %>% read_html()
  #tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    #.[[1]] %>% html_table(dec = ",")
  #for (i in 1:ncol(tabela)) {
    #if (is.character(tabela[[i]])) {
      #Encoding(tabela[[i]]) <- "UTF-8"
    #}
  #}
  #colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        #"ustanovitev", "pokrajina", "regija", "odcepitev")
  #tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  #tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  #tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  #for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    #tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)
  #}
  #for (col in c("obcina", "pokrajina", "regija")) {
    #tabela[[col]] <- factor(tabela[[col]])
  #}
  #return(tabela)
#}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.bdp <- function() {
  data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Ekonomska_rast.csv", 
                    col_names = c("leto", "rast (index 1995)", "dohodek"),
                    locale = locale(encoding = "Windows-1250"), skip = 3, n_max = 11, na = "...")
  #data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    #strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
  #data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  #data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
                        #value.name = "stevilo.druzin")
  #data$velikost.druzine <- parse_number(data$velikost.druzine)
  #data$obcina <- factor(data$obcina, levels = obcine)
  #return(data)
}

uvozi.izdatke <- function() 
  data <- read_csv2("U:/Šilc Ines/APPR-2017-18/podatki/Socialna_zascita.csv",
                    locale = locale(encoding = "Windows-1250"), n_max = 11)
# Zapišimo podatke v razpredelnico obcine
rast <- uvozi.bdp()
izdatki <- uvozi.izdatke()

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih fazah
