#' Datos de padrón scoreado por Nosis usado para construir modelos de predicción de permanencia de afiliados
#'
#' @format Datos tabulares con 24 columnas:
#' \describe{
#'   \item{AFI_ID}{Código de identificación del afiliado, por ej.: '752927'}
#'   \item{AFILIADO}{Apellido y nombres del afiliado, por ej.: 'PEREZ JUAN'}
#'   \item{MOTIVO_BAJA}{Razón por la que el afiliado se dio de baja, por ej.: 'BAJA POR MOTIVOS PERSONALES'}
#'   \item{PERIODO_ALTA}{Año y mes en que el afiliado se dio de alta, por ej.: '202308'}
#'   \item{PERIODO_BAJA}{Año y mes en que el afiliado se dio de baja, por ej.: '202312'}
#'   \item{FLAG_BAJA}{Estado actual ('ACTIVO' o 'BAJA')}
#'   \item{SEXO}{Género del afiliado ('M' o 'F')}
#'   \item{SCO}{Score asignado por Nosis, por ej.: '420'}
#'   \item{NSE}{Nivel Socio Económico reportado por Nosis, por ej.: 'C1'}
#'   \item{CODIGO}{Código, por ej.: '362421/13'}
#'   \item{TIPO}{Tipo de afiliado, por ej.: 'TIT', 'FAM'}
#'   \item{SEGMENTO}{Segmento, por ej.: 'OBLDIR', 'VOLDIR'}
#'   \item{AGENCIA}{Agencia, por ej.: '650419'}
#'   \item{EDAD}{Edad del afiliado, por ej.: '41'}
#'   \item{PLAN}{Plan del afiliado, por ej.: 'AS204', 'AS300'}
#'   \item{PROMOTOR}{Promotor, por ej.: 'JLOPEZ'}
#'   \item{CANAL}{Canal, por ej.: 'Promotor', 'Agencia'}
#'   \item{AGENCIA_NOMBRE}{Nombre de la agencia, por ej.: '650419_AVALIAN CORONEL SUAREZ'}
#'   \item{REGION}{Región, por ej.: 'AMBA'}
#'   \item{ZONACOMERCIAL}{Zona comercial, por ej.: 'AMBA', 'BUENOS AIRES SUR'}
#'   \item{TITULAR}{AFI_ID del titular, por ej.: '155950'}
#'   \item{ESTADO_ACTUAL}{Estado actual del afiliado, por ej.: 'A', 'B'}
#'   \item{CANT_INT}{Cantidad de integrantes del grupo familiar, por ej.: '3'}
#' }
#' @source Archivo 'inst/extdata/padron_scoreado.csv'
"data"
