# perfilarJSON.R

#' @title Perfila potenciales clientes
#' @description Esta función toma descriptores del potencial afiliado en formato JSON y
#' devuelve una predicción de baja temprana (indicada como el campo PREDICCION = 1).
#' @param inputFile Ubicación del input JSON file.
#' @return JSON data con los resultados del perfilado.
#' @export

perfilarJSON <- function(inputFile){  # por ejemplo: inputFile='inst/extdata/sample_query_data.json'

  data <- jsonlite::read_json(inputFile, simplifyVector=TRUE)
  columnasOriginales <- colnames(data)
  data <- calcularScoreAdmision(data)
  data <- convertirAFactor(data)

  # descomponer en los distintos casos según segmento
  data_OBLDIR <- data[data$SEGMENTO == 'OBLDIR', ]
  data_VOLDIR <- data[data$SEGMENTO == 'VOLDIR', ]

  # descomponer los anteriores según cantidadIntegrantes
  # OBLDIR
  data_OBLDIR_GF1 <- data_OBLDIR[data_OBLDIR$CANT_INT == 1, ]
  data_OBLDIR_GF2 <- data_OBLDIR[data_OBLDIR$CANT_INT == 2, ]
  data_OBLDIR_GF3 <- data_OBLDIR[data_OBLDIR$CANT_INT == 3, ]
  data_OBLDIR_GF4 <- data_OBLDIR[data_OBLDIR$CANT_INT == 4 | data_OBLDIR$CANT_INT == 5 | data_OBLDIR$CANT_INT == 6 | data_OBLDIR$CANT_INT == 7 | data_OBLDIR$CANT_INT == 8 | data_OBLDIR$CANT_INT == 9 | data_OBLDIR$CANT_INT == 10| data_OBLDIR$CANT_INT == 11 | data_OBLDIR$CANT_INT == 12, ]
  # VOLDIR
  data_VOLDIR_GF1 <- data_VOLDIR[data_VOLDIR$CANT_INT == 1, ]
  data_VOLDIR_GF2 <- data_VOLDIR[data_VOLDIR$CANT_INT == 2, ]
  data_VOLDIR_GF3 <- data_VOLDIR[data_VOLDIR$CANT_INT == 3, ]
  data_VOLDIR_GF4 <- data_VOLDIR[data_VOLDIR$CANT_INT == 4 | data_VOLDIR$CANT_INT == 5 | data_VOLDIR$CANT_INT == 6 | data_VOLDIR$CANT_INT == 7 | data_VOLDIR$CANT_INT == 8 | data_VOLDIR$CANT_INT == 9 | data_VOLDIR$CANT_INT == 10| data_VOLDIR$CANT_INT == 11 | data_VOLDIR$CANT_INT == 12, ]

  # perfilar

  # OBLDIR
  # GF1
  xtest <- data_OBLDIR_GF1[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF1_OBLDIR_12m_thr0.7.RData")
  data_OBLDIR_GF1$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF2
  xtest <- data_OBLDIR_GF2[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF2_OBLDIR_12m_thr0.7.RData")
  data_OBLDIR_GF2$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF3
  xtest <- data_OBLDIR_GF3[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF3_OBLDIR_12m_thr0.7.RData")
  data_OBLDIR_GF3$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF4
  xtest <- data_OBLDIR_GF4[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF4_OBLDIR_12m_thr0.7.RData")
  data_OBLDIR_GF4$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]

  # VOLDIR
  # GF1
  xtest <- data_VOLDIR_GF1[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF1_VOLDIR_12m_thr0.7.RData")
  data_VOLDIR_GF1$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF2
  xtest <- data_VOLDIR_GF2[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF2_VOLDIR_12m_thr0.7.RData")
  data_VOLDIR_GF2$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF3
  xtest <- data_VOLDIR_GF3[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF3_VOLDIR_12m_thr0.7.RData")
  data_VOLDIR_GF3$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]
  # GF4
  xtest <- data_VOLDIR_GF4[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)
  model <- readRDS("models/model_GF4_VOLDIR_12m_thr0.7.RData")
  data_VOLDIR_GF4$PREDICCION <- predict(model, newdata=xtest, type="prob")[, 2]

  # juntar todos los bloques de predicciones
  resultado_OBLDIR <- rbind(data_OBLDIR_GF1, data_OBLDIR_GF2, data_OBLDIR_GF3, data_OBLDIR_GF4)
  resultado_VOLDIR <- rbind(data_VOLDIR_GF1, data_VOLDIR_GF2, data_VOLDIR_GF3, data_VOLDIR_GF4)
  resultado <- rbind(resultado_OBLDIR, resultado_VOLDIR)

  # reasignar probabilidades predichas dentro de cada grupo familiar
  resultado$PREDICCION <- ave(resultado$PREDICCION, resultado$TITULAR)

  # binarizar
  resultado$PREDICCION <- ifelse(resultado$PREDICCION > modelThreshold, 1, 0)

  # limpiar columnas
  out <- resultado[, c(columnasOriginales, 'PREDICCION')]

  return(jsonlite::toJSON(out, pretty=TRUE))
}
