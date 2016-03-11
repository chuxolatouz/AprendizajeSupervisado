library('xlsx')
# Seleccionar google_api.R en su sistema de archivos
source(file.choose())

df <- read.xlsx("hogares.xlsx", sheetIndex = 1, startRow = 1, endRow = 104, header = T)

df$Foto = NULL
df$Distrito = NULL
df$Habitaciones.Disponibles = NULL

df$Tipo.de.Inmueble <- as.character(df$Tipo.de.Inmueble)

df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Mini appartamento"] <- NULL
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Mini Appartamento"] <- NULL
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Mini\nAppartamento"] <- NULL

df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Appartamento"] <- 1
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Appartameno"] <- 1
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Appartamenti"] <- 1
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Apartamento"] <- 1
df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Apparrtamento"] <- 1

df$Tipo.de.Inmueble[df$Tipo.de.Inmueble == "Monolocale"] <- 2

df$Piso <- as.character(df$Piso)

df$Piso[df$Piso == "T"] <- 1
df$Piso[df$Piso == "R"] <- 1
df$Piso[df$Piso == "S"] <- 1
df$Piso[df$Piso == "ST"] <- 1
df$Piso <- gsub("°","",df$Piso)

df$Dirección <- gsub("\n"," ",df$Dirección)
api_key = "AIzaSyBG65bqbSYkHBe25jbQ08jHZMzOtfa4fys"
origen = "Università di Roma - Sapienza"
for( i in 1:nrow((df))){
  # Colocar su API Key 
  destino = "Gallia"
  destino = as.character(df$Dirección[i])
  api_url = get_url(origen, destino, api_key)
  datos = get_data(api_url)
  datos$rows$elements[[1]]$status
  if(datos$rows$elements[[1]]$status == "ZERO_RESULTS" || datos$rows$elements[[1]]$status == "NOT_FOUND"){
    tiempo = 0
  } else {
    tiempo = parse_data(datos)
    
  }
  df$Dirección[i]= tiempo
  
}


df$Descripción <- as.character(df$Descripción)
df$Descripción <- gsub("2 bagno,","2",df$Descripción)
df$Descripción <- gsub("2 bagni","2",df$Descripción)
df$Descripción <- gsub("2 bagni.","2",df$Descripción)
df$Descripción <- gsub("2bagni","2",df$Descripción)
df$Descripción <- gsub("3 bagni","3",df$Descripción)
df$Descripción <- gsub("Ingresso,","1",df$Descripción)
df$Descripción <- gsub("Ingresso con","1",df$Descripción)
df$Descripción <- gsub("ingresso con","1",df$Descripción)
df$Descripción <- gsub("ingresso,","1",df$Descripción)
df$Descripción <- gsub("ingresso,","1",df$Descripción)
df$Descripción <- gsub("Ingresso/corridoio,","2",df$Descripción)
df$Descripción <- gsub("Ingresso/salone","2",df$Descripción)
df$Descripción <- gsub("Ingresso/soggiorno,","2",df$Descripción)
df$Descripción <- gsub("Ingresso/living,","2",df$Descripción)
df$Descripción <- gsub("cucna,","1",df$Descripción)
df$Descripción <- gsub("cucina,","1",df$Descripción)
df$Descripción <- gsub("cucina abitabile,","1",df$Descripción)
df$Descripción <- gsub("cucina abitbile,","1",df$Descripción)
df$Descripción <- gsub("soggiorno,","1",df$Descripción)
df$Descripción <- gsub("corridoio,","1",df$Descripción)
df$Descripción <- gsub("ingresso cucina/living,","2",df$Descripción)
df$Descripción <- gsub("cucina/living,","2",df$Descripción)
df$Descripción <- gsub("terrazzo","4",df$Descripción)
df$Descripción <- gsub("balcone","3",df$Descripción)
df$Descripción <- gsub("balconcino","3",df$Descripción)
df$Descripción <- gsub("internet","4",df$Descripción)
df$Descripción <- gsub("4 camere,","2",df$Descripción)
df$Descripción <- gsub("camera matrimoniale,","3",df$Descripción)
df$Descripción <- gsub("3 camere,","2",df$Descripción)
df$Descripción <- gsub("2 camere,","1",df$Descripción)
df$Descripción <- gsub("1 camere,","",df$Descripción)
df$Descripción <- gsub("camere,","",df$Descripción)
df$Descripción <- gsub("camere","",df$Descripción)
df$Descripción <- gsub("camer,","",df$Descripción)
df$Descripción <- gsub("camera,","",df$Descripción)
df$Descripción <- gsub("salone,","1",df$Descripción)
df$Descripción <- gsub("salone/living,","1",df$Descripción)
df$Descripción <- gsub("salottino,","1",df$Descripción)
df$Descripción <- gsub("salone","1",df$Descripción)
df$Descripción <- gsub("sala da pranzo,","1",df$Descripción)
df$Descripción <- gsub("living","1",df$Descripción)
df$Descripción <- gsub("cucina","1",df$Descripción)
df$Descripción <- gsub("ripostiglio,","1",df$Descripción)
df$Descripción <- gsub("bagno di servizio,","1",df$Descripción)
df$Descripción <- gsub("bagno,","1",df$Descripción)
df$Descripción <- gsub("bagno","1",df$Descripción)
df$Descripción <- gsub("bagni","1",df$Descripción)
df$Descripción <- gsub("doppio","1",df$Descripción)
df$Descripción <- gsub("doppio,","1",df$Descripción)
df$Descripción <- gsub("angolo cottura,","1",df$Descripción)
df$Descripción <- gsub("camera e","1",df$Descripción)
df$Descripción <- gsub("aria condizionata,","3",df$Descripción)
df$Descripción <- gsub("disimpegno,","1",df$Descripción)
df$Descripción <- gsub("Ingresso","1",df$Descripción)
df$Descripción <- gsub("ristrutturato","1",df$Descripción)
df$Descripción <- gsub("di servizio","",df$Descripción)
df$Descripción <- gsub("termo autonomo","2",df$Descripción)
df$Descripción <- gsub("ripostiglio","1",df$Descripción)
df$Descripción <- gsub("salotto,","1",df$Descripción)
df$Descripción <- gsub("piccolo","1",df$Descripción)
df$Descripción <- gsub("stanze","1",df$Descripción)
df$Descripción <- gsub("ampiio","1",df$Descripción)
df$Descripción <- gsub("con","",df$Descripción)
df$Descripción <- gsub("2,","2",df$Descripción)
df$Descripción <- gsub("1,","1",df$Descripción)
df$Descripción <- gsub("3,","3",df$Descripción)
df$Descripción <- gsub("1.","1",df$Descripción)
df$Descripción <- gsub("2.","2",df$Descripción)
df$Descripción <- gsub("3 ","3",df$Descripción)
df$Descripción <- gsub(" 3","3",df$Descripción)
df$Descripción <- gsub("1 ","1",df$Descripción)
df$Descripción <- gsub(" 2","1",df$Descripción)
df$Descripción <- gsub("tre","",df$Descripción)
df$Descripción <- gsub("e","",df$Descripción)
df$Descripción[38] = "7"
df$Descripción[62] = "6"
df$Descripción[103] = "4"


