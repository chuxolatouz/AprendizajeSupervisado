
# Seleccionar google_api.R en su sistema de archivos
source(file.choose())

origen = c("Via Paolo Emilio", "Vancouver BC", "Seattle")
destino =c("Piazzale Aldo Moro", "San Francisco", "Victoria BC")

# Colocar su API Key 
api_key = "AIzaSyBG65bqbSYkHBe25jbQ08jHZMzOtfa4fys"

api_url = get_url(origen, destino, api_key)

datos = get_data(api_url)
