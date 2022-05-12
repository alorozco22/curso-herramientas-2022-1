########################################################
# Herramientas de programación para el análisis de datos
#Taller 1
#2022-1
########################################################

#Punto 1
########################################################

#a.
(40*5)+17>23+45

#b.
82/4+12<2^4+10

#c.
log(2.718)**8>((2**4)-(5*3))

#d.
(2^3 +12)-5 != (8*3)-9

#e.
(3+2+7)>(5+6) & (18-2-3)<=(9+3+1)


#Punto 2
########################################################
mi_edad=20
mi_edad_meses=mi_edad*12

#Punto 3
########################################################
for (i in seq(2,14,by=2)) {
  print(i)
}

#Punto 4
########################################################
x=0
for (i in seq(1,10,by=2)) {
  x=x+i
}
x

#Punto 5
########################################################
a=matrix(1:4, nrow = 2, ncol = 2)
result=0
for (i in 1:ncol(a)) {
  for (j in 1:nrow(a)) {
    result = result + a[i, j]
  }
}
result


#Punto 6
########################################################
limite=3.0
notas=c(2.8, 3.5, 2.9, 4.3, 1.5)
for (i in notas) {
  if (i>limite) {
    print("pasaría")  
  } else {
    print("no pasaría")
  }
}


#Punto 7
########################################################
vector=c(2.8, 3.5, 2.9, 4.3, 1.5)
mediana=median(vector)
for (i in vector) {
  if (i<=mediana) {
    print(i)  
  } else {

  }
}

#Punto 8
########################################################
area = function(lado){
  res=lado*lado
  return(res)
}

#Ejemplo:
area(8)

#Punto 9
########################################################
tras <- function(M) {
  return(t(M))
}

#Ejemplo:
a=matrix(1:6, nrow = 2, ncol = 3)
tras(a)
