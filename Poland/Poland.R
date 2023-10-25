library(rjson)
library(plotly)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Load GeoJSON data for Polish voivodeships
url <- ".//poland-with-regions_.geojson"
voivodeships_geojson <- rjson::fromJSON(file = url)

df <- data.frame(
  voivodeship = c( "Dolnośląskie", "Kujawsko-Pomorskie", "Łódzkie", "Lubelskie", "Lubuskie","Małopolskie", "Mazowieckie", "Opolskie", "Podkarpackie", "Podlaskie", "Pomorskie", "Śląskie", "Świętokrzyskie","Warmińsko-Mazurskie", "Wielkopolskie", "Zachodniopomorskie"),
  id = c("5307", "5304", "5315", "5305", "5308","5306", "5309", "5310", "5313", "5311", "5312", "5316", "5302", "5317", "5303", "5314"),
  population = c( 2888033, 2006876, 2394946, 2038299, 982655, 3430370,  5512794, 948583, 2085932, 1148720, 2346065, 4375947, 1187700, 1374700	, 3500000	, 1650000)
)

source_text <- "Data: https://pl.wikipedia.org/wiki/Województwo"
license_text <- "GeoJSON: https://cartographyvectors.com/map/1502-poland-with-regions"

fig <- plot_ly() 
fig <- fig %>% add_trace(
  type="choroplethmapbox",
  geojson=voivodeships_geojson,
  locations=df$id,
  z=df$population,
  text = df$voivodeship,
  colorscale="Viridis",
  marker=list(line=list(
    width=0),
    opacity=0.5
  )
)
fig <- fig %>% layout(
  mapbox=list(
    style="carto-positron",
    zoom =5.5,
    center=list(lon= 19.2, lat=52.1)),
  title = "Population of Polish Voivodeships",
  annotations = list(
    list(
      text = source_text,
      showarrow = FALSE,
      x = 0.02,  
      y = -0.02,
      xref = "paper",
      yref = "paper",
      xanchor = "left",
      yanchor = "bottom"  
    ),
    list(
      text = license_text,
      showarrow = FALSE,
      x = 0.02,  
      y =- 0.05,
      xref = "paper",
      yref = "paper",
      xanchor = "left",
      yanchor = "bottom"  
    )
  )
)
fig