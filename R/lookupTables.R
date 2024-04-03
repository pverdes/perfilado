# lookup tables

# Sexo
lookup_table_Sexo <- data.frame(old = c("M", 
                                        "F"),
                                new = c(0.15141373, 
                                        0.01525293))

# Plan
lookup_table_Plan <- data.frame(old = c('AS100',
                                        'AS200',
                                        'AS204',
                                        'AS300',
                                        'AS400',
                                        'AS500'),
                                new = c(0.00340412,
                                        0.04726592,
                                        0.07806095,
                                        0.04046603,
                                        -0.00373218,
                                        0.00120184))

# Segmento
lookup_table_Segmento <- data.frame(old = c('OBLEMP',
                                            'VOLEMP',
                                            'OBLDIR',
                                            'VOLDIR'),
                                    new = c(0.01167404,
                                            0.00554030,
                                            0.09538298,
                                            0.05406935))

# AntiguedadTitularRango
lookup_table_Antiguedad <- data.frame(old = c("0-Menos de 1 Año", 
                                              "1-De 1 a 3 Años",
                                              "3-Más de 3 Años"),
                                      new = c(0.0549039, 
                                              0.0417913,
                                              0.0699715))

# EdadActual
computeScoreEdadActual <- function(edad){
  if(edad >= 60){
    s <- 0.00541244495301357
  } else {
    if(edad >= 45){
      s <- 0.0303951282202615
    } else {
      if(edad >= 26){
        s <- 0.114200339076568
      } else {
        s <- 0.0166587544168238
      }
    }
  }
  return(s)
}

# CantidadIntegrantes
lookup_table_CantidadIntegrantes <- data.frame(old = c('1',
                                                       '2',
                                                       '3',
                                                       '4',
                                                       '5',
                                                       '6',
                                                       '7',
                                                       '8',
                                                       '9'),
                                               new = c(0.06880640,
                                                       -0.04532751,
                                                       0.02959243,
                                                       0.07094614,
                                                       0.03107715,
                                                       0.00854440,
                                                       0.00208151,
                                                       0.00052402,
                                                       0.00042213))



