# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# MONITORIA 6 (06/10/2022)

# DISTRIB. NORMAL PADRÃO
dnorm(-1.96, mean=0, sd=1)
dnorm(1.96, mean=0, sd=1)

pnorm(-1.96, mean=0, sd=1)
pnorm(1.96, mean=0, sd=1)

qnorm(0.025, mean=0, sd=1)
qnorm(0.975, mean=0, sd=1)


# Gráfico com distrib. normal padrão
Z = seq(-3.5, 3.5, by=0.1)
probs = seq(0.001, 0.999, by=0.001)

# Calcular as densidades, prob acumuladas e escores padrão
pdf_norm = dnorm(Z, mean=0, sd=1)
cdf_norm = pnorm(Z, mean=0, sd=1)
qt_norm = qnorm(probs, mean=0, sd=1)


plot(Z, pdf_norm, type="l") # função de densidade de probabilidade
plot(Z, cdf_norm, type="l") # função de distrb acumulada
plot(probs, qt_norm, type="l") # retorna escore Z a partir de probs



# AMOSTRAGEM
sample(1:10, replace=T)

# Visualização da LGN
sample(1:6, 1)

amostra = replicate(500, expr=sample(1:6, 1))
plot(table(amostra))

# sorteio de 2 números e cálculo da média
mean(sample(1:6, 2, replace=T))

amostra = replicate(500, expr=mean(sample(1:6, 2, replace=T)))
plot(table(amostra))

# sorteio de X números e cálculo da média
X = 1
mean(sample(1:6, X, replace=T))

amostra = replicate(500, expr=mean(sample(1:6, X, replace=T)))
plot(table(amostra), xlim=c(1, 6))


# Geração de números aleatórios
rnorm(10, mean=0, sd=1)

set.seed(2)
rnorm(10, mean=0, sd=1)

# EXEMPLO 1
a0 = 50
b0 = -5
N = 200

set.seed(1)
e = rnorm(N, 0, 2)
x = rnorm(N, 5, 0.5)

y = a0 + b0*x + e

lm(y ~ x)


# EXEMPLO 2
a0 = 50
b0 = -5
c0 = 3
N = 200

set.seed(1)
e = rnorm(N, 0, 2)
x = rnorm(N, 5, 0.5)
z = rnorm(N, 1.91, 0.25)

y = a0 + b0*x + c0*z + e

lm(y ~ x)
lm(y ~ x + z)


# EXEMPLO 3
a0 = 50
b0 = -5
c0 = 3
N = 200

set.seed(1)
e = rnorm(N, 0, 2)
x = rnorm(N, 5, 0.5)
z = rnorm(N, 1.91*x, 0.25*x)

y = a0 + b0*x + c0*z + e

lm(y ~ x)
lm(y ~ x + z)


# EXEMPLO 4
a0 = 50
b0 = -5
N = 200

set.seed(1)
e = rnorm(N, 10, 2)
x = rnorm(N, 5, 0.5)

y = a0 + b0*x + e

lm(y ~ x)


