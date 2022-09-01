# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# MONITORIA 3 (01/09/2022)

# Operações vetoriais/matriciais
x = 1:4
y = 6:9

x + y
x * y


# produto de vetores
x %*% y
x %*% t(y)

x_lin = matrix(x, nrow=1)
y_col = matrix(y, ncol=1)

x_lin %*% y_col
t(x_lin) %*% t(y_col)


# Estatíscas básicas a partir de vetores
x = c(1, 4, -5, 2, 8, -2, 4, 7, 8, 0, 2, 3, -5, 7, 4, -4, 2, 5, 2, -3)
length(x)

abs(x)
sum(x)
mean(x)
sd(x)
quantile(x, probs = seq(0, 1, 0.25))
max(x)
min(x)

which.max(x)
which.min(x)
which(x==max(x))
which(x==min(x))


# Vetor com NA's
x = c(1, 4, -5, 2, NA, -2, 4, 7, 8, 0, NA, 3, -5, 7, NA, -4, NA, 5, 2, -3)
x
sum(x, na.rm=TRUE)



## ESTRUTURAS DE CONTROLE

### IF/ELSE - Estrutura condicional
x = -1

if (x > 3) {
    print("OI")
} else if (x >= 0) {
    print("dfsdgsdfsd")  
} else {
    print("TCHAU")
}

### FOR - Estrutura para repetição
vetor = 3:7

for (var in vetor) {
    print(var^2)
}


### WHILE - Estrutura de repetição
i = 10
contador = 0

while (i > 0.001) {
    i = i / 2
    contador = contador + 1
}



## Otimização de função univariada
x_grid = seq(-5, 5, length=100)

fx = x_grid^2 + 4*x_grid - 4
fx

plot(fx)
cbind(x_grid, fx)

indice_x = which.min(fx)
x_grid[indice_x]


## Otimização de função bivariada
x_grid = seq(-5, 5, length=20)
z_grid = seq(-6, 5, length=10)

fxz = matrix(NA, length(x_grid), length(z_grid))
fxz
colnames(fxz) = round(z_grid, 2)
rownames(fxz) = round(x_grid, 2)
fxz

lin = 1
col = 1
for (x_val in x_grid) {
    for (z_val in z_grid) {
        fxz[lin, col] = x_val^2 + 4*z_val^2 - 4
        col = col +1
    }
    col = 1
    lin = lin + 1
}
round(fxz, 2)

min(fxz)
which(fxz == min(fxz), arr.ind=TRUE)
