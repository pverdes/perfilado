crearRdaData <- function(){

  data <- read.csv(sprintf("inst/extdata/%s", padronNosis))
  data <- limpiarDatos(data)
  save(data, file = "data/data.rda")

  return(0)
}
