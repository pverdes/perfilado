crearModelo <- function(data,
                        cantidadIntegrantes,  # por ej. 1
                        segmento,             # por ej. 'OBLDIR'
                        permanenciaMinima,    # en meses, por ej. 12
                        PRED_INI,             # por ej. 202210
                        PRED_FIN,             # por ej. 202301
                        thr){                 # por ej. 0.7

  cat("\n####################################\n\n")
  cat("Performance sobre el:\n")
  cat("  - intervalo:", PRED_INI, "-", PRED_FIN, "\n")
  cat("  - grupos familiares de:", cantidadIntegrantes, "miembro(s)\n")
  cat("  - segmento:", segmento, "\n")
  cat("  - permanencia mínima de:", permanenciaMinima, "meses\n\n")

  # etiquetar bajas tempranas
  data <- calcularPermanencia(data)
  data$BAJA_TEMPRANA <- as.factor(ifelse(data$FLAG_BAJA=='BAJA' & data$PERMANENCIA <= permanenciaMinima, 1, 0))
  # conservar sólo afiliados del tipo de GF especificado
  if(cantidadIntegrantes < 4){
    data <- data[data$CANT_INT == cantidadIntegrantes, ]
  } else {
    data <- data[data$CANT_INT == 4 | data$CANT_INT == 5 | data$CANT_INT == 6 | data$CANT_INT == 7 | data$CANT_INT == 8 | data$CANT_INT == 9 | data$CANT_INT == 10| data$CANT_INT == 11 | data$CANT_INT == 12, ]
  }
  # armar conjunto de ajuste
  trainingData <- data[data$PERIODO_ALTA < PRED_INI | data$PERIODO_ALTA > PRED_FIN, ]
  # conservo sólo el SEGMENTO especificado
  if(segmento == 'OBLDIR')  trainingData <- trainingData[trainingData$SEGMENTO == segmento, ]
  # samplear estratificadamente
  trainingData_class_0 <- trainingData[trainingData$BAJA_TEMPRANA==0, ]
  trainingData_class_1 <- trainingData[trainingData$BAJA_TEMPRANA==1, ]
  if(nrow(trainingData_class_0) >= nrow(trainingData_class_1)){
    train_idx <- sample(nrow(trainingData_class_0), size=nrow(trainingData_class_1))
    trainingData <- rbind(trainingData_class_0[train_idx, ], trainingData_class_1)
  } else {
    train_idx <- sample(nrow(trainingData_class_1), size=nrow(trainingData_class_0))
    trainingData <- rbind(trainingData_class_1[train_idx, ], trainingData_class_0)
  }
  # preparar training data para alimentar modelo
  trainingData <- trainingData[, c(modelInputVariables, modelOutputVariable)]
  xtrain <- trainingData[, modelInputVariables]
  ytrain <- trainingData[, modelOutputVariable]
  xtrain <- xtrain %>% select(-SEGMENTO)

  # crear objeto para cross-validation
  #control <- rfeControl(functions = rfFuncs, method = "cv", number = 10)
  # ajustar modelo
  #model <- rfe(xtrain, ytrain, sizes = 10, rfeControl = control, method = "rf")

  trainingData <- trainingData %>% select(-SEGMENTO)
  #model <- glm(BAJA_TEMPRANA ~ ., data=trainingData, family='binomial')
  model <- randomForest(BAJA_TEMPRANA ~ ., data=trainingData)

  # construir intervalo de predicción
  data_PRED <- data[data$PERIODO_ALTA >= PRED_INI & data$PERIODO_ALTA <= PRED_FIN, ]
  data_PRED <- data_PRED[data_PRED$SEGMENTO == segmento, ]
  xtest <- data_PRED[, modelInputVariables]
  xtest <- xtest %>% select(-SEGMENTO)

  # hacer predicciones individuales sobre el conjunto de test
  data_PRED$PRED <- predict(model, newdata=xtest, type="prob")[, 2]#$`1`
  # binarizar predicciones
  data_PRED$PRED <- ifelse(data_PRED$PRED > thr, 1, 0)
  # calcular matriz de confusión
  if(sum(as.numeric(data_PRED$BAJA_TEMPRANA)) > 0){
    CM_test_PRED <- caret::confusionMatrix(data = as.factor(data_PRED$PRED),
                                           reference = as.factor(data_PRED$BAJA_TEMPRANA),
                                           positive = "1",
                                           mode = "everything")
    print(CM_test_PRED$table)
  }

  return(model)
}

