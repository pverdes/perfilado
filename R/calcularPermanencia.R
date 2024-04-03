calcularPermanencia <- function(data){

  # trabajo sobre una copia de los datos
  data_aux <- data
  # convertir fechas a numero de meses
  # altas
  anio <- data_aux$PERIODO_ALTA %/% 100
  meses <- data_aux$PERIODO_ALTA - 100 * anio
  data_aux$mesesAlta <- anio * 12 + meses
  # bajas
  # creo variable auxiliar
  data_aux$PERIODO_BAJA_AUX <- data_aux$PERIODO_BAJA
  idx <- which(is.na(data_aux$PERIODO_BAJA_AUX))
  # construct a replacement for NA in PERIODO_BAJA
  replacementForNA <- max(c(data_aux$PERIODO_ALTA, data_aux$PERIODO_BAJA), na.rm=TRUE)
  data_aux$PERIODO_BAJA_AUX[idx] <- replacementForNA
  anio <- data_aux$PERIODO_BAJA_AUX %/% 100
  meses <- data_aux$PERIODO_BAJA_AUX - 100 * anio
  data_aux$mesesBaja <- anio * 12 + meses
  # permanencia
  data$PERMANENCIA <- data_aux$mesesBaja - data_aux$mesesAlta

  return(data)
}
