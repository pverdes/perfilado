calcularScoreAdmision <- function(data){

  # pasar a mayusculas los nombres de las columnas
  columnasOriginales <- colnames(data)

  # calcular scores individuales segun descriptores
  # Plan
  data$scorePlan <- lookup_table_Plan$new[match(data$PLAN,
                                                lookup_table_Plan$old)]
  # Sexo
  data$scoreSexo <- lookup_table_Sexo$new[match(data$SEXO,
                                                lookup_table_Sexo$old)]
  # Segmento
  data$scoreSegmento <- lookup_table_Segmento$new[match(data$SEGMENTO,
                                                        lookup_table_Segmento$old)]
  # EdadActual
  data$scoreEdadActual <- apply(X=subset(data, select = c("EDAD")),
                                MARGIN=1,
                                FUN=computeScoreEdadActual)
  # CantidadIntegrantes
  data$scoreCantidadIntegrantes <- lookup_table_CantidadIntegrantes$new[match(data$CANT_INT,
                                                                              lookup_table_CantidadIntegrantes$old)]
  # score final
  data$scoreADMISION <- data$scorePlan + data$scoreSexo + data$scoreSegmento + data$scoreEdadActual + data$scoreCantidadIntegrantes

  # poner scoreADMISION = 0 a los mayores de 55
  idx <- which(data$EDAD > 55)
  data$scoreADMISION[idx] <- 0

  data$scoreADMISION <- ave(data$scoreADMISION, data$TITULAR)

  # subset to final columns
  data <- data[, c(columnasOriginales, "scoreADMISION")]

  return(data)
}
