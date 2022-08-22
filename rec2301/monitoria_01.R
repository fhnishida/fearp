1+1

2+3+5-4

4*2

setwd("C:/Users/fhnis/OneDrive/FEA-RP/PAE/Monitoria")

rnorm(n=10, mean=0, sd=1)
rnorm(n=10) # padrão: média = 0, desvio padrão = 1
rnorm(10, 0, 1)
rnorm(mean=100, sd=5, n=20) # para chamar fora de ordem, precisa usar nome
# do argumento

?rnorm # Ajuda

hist(rnorm(n=1000, mean=0, sd=1))

library(ggplot2)

# Instalação via Github
library(devtools)
install_github("hadley/dplyr")

dplyr::starwars

library(dplyr)
starwars


# Operações básicas em R
1+1
1-2
1*3
4/2

5%/%2
5%%2

8^2
sqrt(4)
8^(1/2)


# Objetos
obj1 = 5
obj2 <- 5 + 2

obj1 = obj2
obj1

obj1 = obj1 + 1
obj1

# verificar as classes dos objetos usando class()
class(obj1)
class(10)

obj3 = "texto"
obj3
class(obj3)

class(10L)
10L

class(10 + 7i)

class(TRUE)
class(FALSE)
class(T)
class(F)


# Expressões lógicas/booleanas
2 < 20
200 > 500
20 <= 20
50 == 50
50 != 50

50 >= 50 & 50 == 50
50 != 50 | 50 < 50


# Vetores
x = c(0.5, 0.6)
x

x = c("a", "b", "c")
x

x = 1:9
x

x = 9:1
x

class(x)

y = c(1.7, "a")
y
class(y)

y = c(FALSE, 0.75)
y
class(y)

as.logical(c(FALSE, 0.75))
as.numeric(c(1.7, "a"))
as.numeric(c(1.7, "9"))


