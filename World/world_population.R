library(RMySQL)
library(plotly)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

mysqlconn = dbConnect(MySQL(), user = 'root', password = 'pass', dbname = 'world', host = 'localhost')
res = dbSendQuery(mysqlconn, "SELECT Code, Name, Population FROM country")
df = fetch(res, n = -1)
df[df$Code == "ROM", "Code"] <- "ROU"
new_countries <- data.frame(
  Code = c("MNE", "SRB", "KXK", "SSD"),
  Name = c("Montenegro", "Serbia", "Kosovo", "South Sudan"),
  Population = c(623000, 6974289, 1920079, 10561244)  # Replace population values as needed
)
df <- rbind(df, new_countries)


fig <- plot_ly(df, type='choropleth', locations=df$Code, z=df$Population, text=df$Name, 
               colorscale= list(c(0, "rgb(49,54,149)"), c(1./10000, "rgb(69,117,180)") ,c(1./1000, "rgb(116,173,209)"), c(1./100, "rgb(224,243,248)"), c(1./10,  "rgb(253,174,97)"), c(1., "rgb(215,48,39)") ))
fig <- fig %>%
  layout( title = "Population")

htmlwidgets::saveWidget(fig, ".//world_population.html", selfcontained = TRUE)

dbDisconnect(mysqlconn)