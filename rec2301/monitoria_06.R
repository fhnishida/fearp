# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# MONITORIA 6

# DISTRIBUIÇÕES

# NORMAL PADRÃO
dnorm(1.96, mean=0, sd=1)
dnorm(-1.96, mean=0, sd=1)

pnorm(1.96, mean=0, sd=1)
pnorm(-1.96, mean=0, sd=1)

pnorm(1.96, mean=0, sd=1) - pnorm(-1.96, mean=0, sd=1)

qnorm(0.975, mean=0, sd=1)
qnorm(0.025, mean=0, sd=1)

# Gráfico fdp
curve( dnorm(x, mean=0, sd=1), from=-3, to=3 )
curve( pnorm(x, mean=0, sd=1), from=-3, to=3 )
curve( qnorm(x, mean=0, sd=1), from=0, to=1 )


# T-STUDENT
curve( dnorm(x, mean=0, sd=1), from=-3, to=3 )

curve( dt(x, df=100), from=-3, to=3, add=TRUE, col="red" )


# AMOSTRAGEM ALEATÓRIA
sample(1:10)
sample(letters, 5)


# Exemplo: Visualização da LGN
sample(1:6, 1)

amostra = replicate(500, exp=sample(1:6, 1))
table(amostra)

plot(table(amostra), type="h")


## 2 vezes o dado e fazer média
mean( sample(1:6, 2, replace=TRUE) )

amostra = replicate(500, exp=mean( sample(1:6, 2, replace=T) ))
table(amostra)

plot(table(amostra), type="h")


## N vezes o dado e fazer média
N = 100000

mean( sample(1:6, N, replace=TRUE) )
amostra = replicate(500, exp=mean( sample(1:6, N, replace=T) ))
table(amostra)

plot(table(amostra), type="h", xlim=c(1, 6))


# GERAÇÃO DE NÚMEROS ALEATÓRIOS
rnorm(5)

set.seed(2)
rnorm(5)


# EXEMPLO C.2
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)

Change = SR88 - SR87
1 = length(Change)
avgChange = mean(Change)
sdChange = sd(Change)

# erro padrão
se = sdChange / sqrt(n)
CV = qt(.975, df=n-1)

# limite inferior
avgChange - CV*se

# limite superior
avgChange + CV*se

avgChange + CV * c(-se, se)


# Exemplo C.6
t = (avgChange - 0) / se
CV

abs(t) > CV

p = 2 * (1 - pt(abs(t), n-1))


# Calcular via t.test()
testresults = t.test(Change)
names(testresults)

testresults$p.value
testresults$estimate
