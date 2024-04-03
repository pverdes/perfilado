# nombre del archivo ubicado en 'inst/extdata/' que contiene el padrón scoreado por Nosis
padronNosis <- "padron_scoreado.csv"

# variables que alimentan al modelo de perfilado
modelInputVariables <- c(
  'SEXO',
  'EDAD',
  'SEGMENTO',
  'PLAN',
  'CANAL',
  'REGION',
  'ZONACOMERCIAL',
  'scoreADMISION',
  'NSE',
  'scoreNOSIS')

factorInputVariables <- c(
  'SEXO',
  'PLAN',
  'CANAL',
  'REGION',
  'ZONACOMERCIAL',
  'NSE')

# variables predicha por el modelo de perfilado
modelOutputVariable <- 'BAJA_TEMPRANA'

# umbral para binarizar predicciones del modelo de perfilado
modelThreshold <- 0.7

# máxima edad a usar por el modelo de perfilado
edadTope <- 55

# causales de baja que nos interesan
causalesRelevantes <- c('BAJA POR FALTA DE PAGO (POR COBRANZA)',
                        'BAJA POR PROBLEMAS ECONOMICOS',
                        'BAJA POR CAMBIO DE COBERTURA',
                        'BAJA POR DISCONFORMIDAD',
                        'BAJA POR MOTIVOS PERSONALES',
                        'BAJA POR FALSEAR LA DECLARACION JURADA',
                        'CAMBIO PMO')
