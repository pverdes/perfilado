fitAllModels <- function(){

  load('data/data.rda')

  cantInt <- 1:4
  segs <- c('OBLDIR', 'VOLDIR')
  permMin <- c(4, 12)
  PRED_INI <- PRED_FIN <- 202001
  modelThreshold <- 0.7

  for(cantidadIntegrantes in cantInt){
    for(segmento in segs){
      for(permanenciaMinima in permMin){
        model <- crearModelo(data = data,
                             cantidadIntegrantes = cantidadIntegrantes,
                             segmento = segmento,
                             permanenciaMinima = permanenciaMinima,
                             PRED_INI = PRED_INI,
                             PRED_FIN = PRED_FIN,
                             thr = modelThreshold)
        saveRDS(model, file=sprintf('models/model_GF%s_%s_%sm_thr%s.RData',
                                 cantidadIntegrantes, segmento, permanenciaMinima, modelThreshold))
      }
    }
  }

  return(0)
}
