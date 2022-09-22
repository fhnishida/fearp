# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# MONITORIA 4 (22/09/2022)

# Funções
soma = function(a, b) {
    a + b
}

soma(3, 7)
soma(3:5, 7:9)


# Resumo de dados
View(airquality)
dim(airquality) # dimensão: linhas x colunas
head(airquality, 10) # retornar as primeiras linhas
tail(airquality) # retonar as últimas linhas
str(airquality) # estrutura da base de dados
summary(airquality) # resume a base de dados
quantile(airquality$Ozone, na.rm=T)

head(CO2)
summary(CO2)

table(CO2$Type, CO2$Treatment)
prop.table(table(CO2$Type, CO2$Treatment))

# Família de funções apply
?apply
x = matrix(1:20, 5, 4)

apply(x, MARGIN=2, mean) # média de cada coluna
apply(x, MARGIN=1, mean) # média de cada linha

# aplicação para verificar valores únicos
View(mtcars)
apply(mtcars, 2, unique)

# varificar quantidade de NA's
View(airquality)
View(is.na(airquality))
apply(is.na(airquality), 2, sum)


# lapply
x = list(a=1:5, b=rnorm(10), c=c(1, 4, 65, 6))
x

lapply(x, mean)
lapply(x, summary)


# sapply
sapply(x, mean)
sapply(x, summary)


maior = function(x, num=3) {
    x[x > num]
} 

maior(1:10)

lapply(x, maior, num=3)
sapply(x, maior, num=3)



# MANIPULAÇÃO 
set.seed(2022)
x = data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x

x$var2[c(1, 3)] = NA
x

x[,1]
x[,"var1"]
x[c(1, 3),"var2"]



x[x$var1 <= 3,]
x[x$var1 <= 3 & !is.na(x$var2),]

x$var1 %in% c(1, 3, 7, 9)


# ORDENAÇÃO
sort(x$var1)
sort(x$var1, decreasing=T)
x

order(x$var1)

# INCLUIR NOVAS COLUNAS
x$var4 = rnorm(5)
x

z = rnorm(5)

x = cbind(x, z)
x

w = c(1, 2, 3, 5, 7)
x = rbind(x, w)
x