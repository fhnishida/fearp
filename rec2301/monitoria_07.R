# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# MONITORIA 7 - MODELO DE REGRESSÃO SIMPLES

# Exemplo 2.3
# install.packages("wooldridge")
data(ceosal1, package="wooldridge")

attach(ceosal1)

cov(salary, roe)
var(roe)
mean(roe)
mean(salary)

bhat_1 = cov(salary, roe) / var(roe)
bhat_0 = mean(salary) - bhat_1*mean(roe)

detach(ceosal1)


# Função lm()
lm(ceosal1$salary ~ ceosal1$roe)
lm(salary ~ roe, data=ceosal1)

plot(ceosal1$roe, ceosal1$salary)
abline(lm(salary ~ roe, data=ceosal1), col="red")

CEOregres = lm(salary ~ roe, data=ceosal1)
names(CEOregres)
CEOregres$coefficients


# Valor ajustado e erro
sal = ceosal1$salary
roe = ceosal1$roe

sal_hat = bhat_0 + bhat_1*ceosal1$roe
u_hat = sal - sal_hat

cbind(sal, roe, sal_hat, u_hat)


CEOregres$fitted.values
CEOregres$residuals

fitted(CEOregres)
resid(CEOregres)

mean(u_hat)
cor(roe, u_hat)

mean(sal)
mean(sal_hat)


# Exemplo 2.11

# nível-nível
lm(salary ~ sales, data=ceosal1)

# log-nível
lm(log(salary) ~ sales, data=ceosal1)

# log-log
lm(log(salary) ~ log(sales), data=ceosal1)


# DIFERENÇAS DE MÉDIA
# Exemplo c.6 (mesmo da monitoria 6)
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)

SR = c(SR87, SR88)

group88 = c(rep(0, 20), rep(1, 20))

lm(SR ~ group88)


