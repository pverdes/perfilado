limpiarDatos <- function(data){

  # conservar sólo causales relevantes
  keep <- which(((data$MOTIVO_BAJA %in% causalesRelevantes) & data$FLAG_BAJA == 'BAJA') | data$FLAG_BAJA == 'ACTIVO')
  data <- data[keep, ]
  # conservar sólo afiliados dentro del tope de edad
  data <- data[data$EDAD <= edadTope, ]
  # eliminar NAs en scoreNOSIS
  data <- data[!is.na(data$SCO), ]
  # agregar columna con scoreADMISION
  data <- calcularScoreAdmision(data)
  # eliminar NAs en scoreADMISION
  data <- data[!is.na(data$scoreADMISION), ]
  # eliminar NAs en REGION
  data <- data[data$REGION != "", ]
  # renombrar la columna "SCO" a "scoreNOSIS"
  data <- data %>%
    dplyr::rename(scoreNOSIS = SCO)
  # limpiar NSE
  data <- data[data$NSE != "", ]
  data <- data[data$NSE != "4", ]
  # convertir tipos
  data$SEXO <- as.factor(data$SEXO)
  data$SEGMENTO <- as.factor(data$SEGMENTO)
  data$PLAN <- as.factor(data$PLAN)
  data$CANAL <- as.factor(data$CANAL)
  data$REGION <- as.factor(data$REGION)
  data$ZONACOMERCIAL <- as.factor(data$ZONACOMERCIAL)
  data$NSE <- as.factor(data$NSE)
  data$AFI_ID <- as.character(data$AFI_ID)
  data$TITULAR <- as.character(data$TITULAR)

  return(data)
}
