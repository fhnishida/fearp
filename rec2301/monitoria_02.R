# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# MONITORIA 2
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
?seq
seq(from=1, to=10, by=2)
seq(1, 10, length=8)
seq(1, 4, length=4)


# rep()
rep(1, 10)
rep(c("a", "b"), 5)


# MATRIZES (também precisa todos elementos sejam da mesma classe)
?matrix
matrix(0, nrow=2, ncol=3)
matrix(1:6, nrow=2, ncol=3) # preenchimento por coluna por padrão
matrix(1:6, nrow=2, ncol=3, byrow=TRUE) # preenchimento por linha

# criar matrizes por junção cbind() ou rbind()
x = 1:4
y = 5:8
x
y

cbind(x,y) # por coluna
rbind(x,y) # por linha
class(cbind(x,y)) # matrix


# LISTAS (permite diferentes classes de objeto)
x = list(1L, 0.7, 1+2i, "texto", c(1, 3, 4, 6, 8))
x
class(x)


# DATA FRAMES (bases de dados, tipo especial de lista)
mtcars
class(mtcars)

x = data.frame(col1 = 1:4, col2=7:4, col3=c("a", "b", "c", "d"))
x

# carregando base de dados
setwd("C:/Users/fhnis/OneDrive/FEA-RP/PAE/Monitoria/data")
txt = read.table("mtcars.txt")
csv = read.csv("mtcars.csv")
excel = xlsx::read.xlsx("mtcars.xlsx", sheetIndex=1)

csv_br = read.csv2("mtcars_br.csv")
excel_br = xlsx::read.xlsx("mtcars_br.xlsx", sheetIndex=1)



## SUBSETTING / EXTRAÇÃO SUBCONJUNTOS DE VETORES OU MATRIZES OU DATA FRAMES
# Vetores
x = c(1, 4, 6, 8, 99)
x

x[2] # extraindo 2o elemento
x[1:3]
x[c(1, 2, 3)]

x[c(F, F, F, T, T)] # valor maior que 7
c(3, 2, 1) > 2 # exemplo
x > 7

# substituindo x > 7
x[x > 7] # valor maior que 7


# Listas
x = list(var1=1L, var2=0.7, var3=1+2i, var4="texto", var5=c(1, 3, 4, 6, 8))
x

x[1]
class(x[1])

x[[1]]
class(x[[1]])

x[[5]][2:3]

x$var5
x["var5"]


# Matrizes e Data frames
x = mtcars
x[1, 1]
x[1:3, 1:4]

x[1,]
x[,4:5]

x$mpg
x[,"mpg"]


# Removendo valores ausentes (missing values) - NA
x = read.csv2("mtcars_br.csv")

x = c(1, 2, NA, 4, NA, NA)
sum(x)
sum(c(1, 2, 3, 4))

is.na(x)

x[is.na(x)]
x[!is.na(x)]

sum(is.na(x))


# Exercícios no swirl
library(swirl)
swirl()
