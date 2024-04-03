convertirAFactor <- function(data){

  model <- readRDS("models/model_GF1_OBLDIR_12m_thr0.7.RData")
  for(inputVar in factorInputVariables){
    data[[inputVar]] <- factor(data[[inputVar]], levels=model$forest$xlevels[[inputVar]])
  }

  return(data)
}
