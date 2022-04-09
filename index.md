---
title: "Monitorias de Econometria I (2022)"
author: "Fábio Nishida fabio.nishida@usp.br"
date: "1º Semestre/2022"
output: rmdformats::robobook
# output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Introdução ao R

- Baseado, principalmente nos cursos pertencentes à [_Especialização em Data Science_](www.coursera.org/specializations/jhu-data-science) da universidade John Hopkins disponibilizados no Coursera, e também na experiência própria.
- Em cada tema abordado serão citadas as fontes, além de incluir aos vídeos do curso citado acima para que possam aprofundar nos estudos e fazer os testes para avaliar o aprendizado.
- Alunos USP conseguem fazer determinados cursos/especializações e pegar o certificado sem pagar: [_Universidade de São Paulo BR on Coursera_](https://www.coursera.org/programs/universidade-de-sao-paulo-br-on-coursera-mvxtw?currentTab=CATALOG&fbclid=IwAR3dT_SDYfjT2FWH06mUcSb8V_z4F9aT_1c6MHHQ3gdiDQ9X9mdRhMcsbOk)


## Instalação do R e R Studio
- <https://www.coursera.org/learn/data-scientists-tools/lecture/y6mU2/installing-r>

1. Instalação da base do R (<https://cran.r-project.org>)
    - Download R for Windows > base > Download R X.X.X for Windows
    - Se o computador for 64-bits, opte pela versão 64-bits (é mais rápida)

2. Instalação do Rtools (<https://cran.r-project.org>)
    - Download R for Windows > Rtools > Installing Rtools > rtools40-x86_XX.exe
    - É uma ferramenta para trabalhar nos pacotes de R

3. Instalação do RStudio (<https://www.rstudio.com/products/rstudio/download/#download>)
    - Download RStudio Desktop
    - É uma interface de usuário para facilitar o uso do R


## Usando o R Studio
- <https://www.coursera.org/learn/data-scientists-tools/lecture/0fUNC/rstudio-tour)>

RStudio é dividido em 4 quadrantes:

- superior/esquerdo: source - onde ficam "blocos de nota" (scripts) com comandos a serem salvos
- superior/direito: ambiente - visualizar variáveis
- inferior/esquerdo: console - executar os comandos e ver resultados (é o R "bruto")
- inferior/direito: arquivos/gráficos/pacotes/ajuda

> **Dica**: Alterar o tema do RStudio (fundo branco pode cansar mais a visão num tempo mais longo)<br/>  
Tools > Global Options... > Appearance > Editor theme > Cobalt (meu preferido)

### Diretório de trabalho (_Working Directory_)
Definir um diretório de trabalho facilita o acesso aos arquivos da pasta (base de dados, etc.).

> Session > Set Working Directory > Choose Directory...

```{r}
setwd("C:/Users/Fabio/OneDrive/FEA-RP")
```

> **Dica**: O comando para definir o diretório de trabalho aparecerá no console. Copie e cole no seu script para não precisar definir toda vez que abre o R Studio.

- Note que usa o "slash" (/) ao invés do "backslash" (\\), então não dá para copiar diretamente o endereço de uma pasta e colar no R sem fazer ajustes:
```r
setwd("C:\Users\Fabio\OneDrive\FEA-RP") # ERRADO!
```

```{r}
setwd("C:/Users/Fabio/OneDrive/FEA-RP") # CORRETO!
getwd() # Verificar seu o diretorio de trabalho

setwd("C:\\Users\\Fabio\\OneDrive\\FEA-RP") # CORRETO!
getwd() # Verificar seu o diretorio de trabalho
```

Você pode trocar _backslash_ por _slash_, ou duplicar os _backslashs_.

### Executando comandos no R
- Execução direta no console: escreva `1 + 1` no console e dê \<Enter\>
```{r}
1 + 1
```
- Execução pelo script: escreva o seguinte código abaixo, e dê `Ctrl + Enter` na linha ou no código destacado. Note que o código do script é "jogado" no console.
```{r}
rnorm(n=10, mean=0, sd=1)  # Gerar 10 números ~ N(0, 1)
hist(rnorm(n=1000, mean=0, sd=1))  # Histograma dos números gerados
```



### Ajuda para comandos
```r
?rnorm
```

```yaml
rnorm(n, mean = 0, sd = 1)

n: number of observations. If length(n) > 1, the length is taken to be the number required.
mean: vector of means.
sd: vector of standard deviations.
```

- Note acima em "Usage" que já há valores pré-definidos para `mean = 0` e `sd = 1`. Portanto, se você só informar o `n`, a função irá funcionar, considerando os valores pré-definidos para os demais argumentos.
- É possível escrever o código sem os nomes dos argumentos, mas devem ser inseridos na mesma ordem do descrito na Ajuda.
```r
rnorm(10, 0, 1)
```
- Também podemos trocar a ordem explicitando o nome do argumento (NÃO RECOMENDADO)
```r
rnorm(mean=0, n=10, sd=1)
```

## Pacotes do R
- Pacotes são coleções de funções, dados e códigos escritos por outras pessoas
- Por ser um software _open source_, o R possui muitos pacotes disponibilizados pela internet e muitos economistas (principalmente econometristas) já desenvolvem e disponibilizam pacotes com as implementações de seus novos métodos (por exemplo, Dif-in-Dif com múltiplos períodos de [Callaway e Sant'Anna (2021)](https://bcallaway11.github.io/did/articles/did-basics.html))
- A instalação de um pacote só precisa ser feita uma única vez.
- No entanto, caso você atualize uma nova versão do R, é necessário instalar novamente todos os pacotes.
- Os pacotes podem ser obtidos em bibliotecas (_libraries_), como CRAN, e de indivíduos (normalmente disponibilizados no GitHub)
- O CRAN é administrado e, como existe uma curadoria para inserção e manutenção de pacotes novos e defasados, garante qualidade dos pacotes disponibilizados
- Tome cuidado com pacotes disponibilizados por individuos! É possível executar, dentro do R, códigos para criar e apagar arquivos, por exemplo.

### Instalação via CRAN
> quadrante inferior/direito > Packages > Install > (Nomes dos pacotes)

```r
install.packages("ggplot2") # Pacote para criar graficos
```

### Instalação via GitHub
- Primeiro, é necessário instalar o pacote `devtools`
```r
install.packages("devtools")
```
- Depois, é preciso obter o nome do author (do GitHub) e nome do pacote. Como exemplo, iremos baixar o pacote `dplyr` do autor `hadley` (este pacote, na realidade, pode ser baixado direto do CRAN).
- Para executar uma função de um pacote, podemos usar `<pacote>::<funcao>`
```r
devtools::install_github("hadley/dplyr")
```

- Ou é possível carregar o pacote no ambiente e, depois, chamar a função do pacote carregado
```r
library(devtools)
install_github("hadley/dplyr")
```

- CUIDADO! Ao carregar varios pacotes, talvez tenha 2 funções com mesmo nome
    - R prioriza a função do pacote carregado por último
```{r}
library(dplyr) # Pacote para manipulacao de base de dados
library(MASS) # Normalmente nao eh carregado diretamente (via outro pacote)
```

- Uma forma de contornar o problema é usar `<pacote>::<funcao>`
```r
select(obj) # do pacote MASS
dplyr::select(.data, ...) # do pacote dplyr
```

### Atualizando pacotes
> quadrante inferior/direito > Packages > Update > Select All > Install Updates


> DICA: para saber como usar um pacote, veja sua página no CRAN:
>
> <https://cran.r-project.org/web/packages/dplyr/index.html>
> 
> Reference manual: ver todas funções e dados presentes no pacote
>
> Vignettes: exemplos de uso das funções de um pacote

```r
browseVignettes("dplyr") # Abrirá uma página com vignettes no seu navegador
```

## Sincronização de projeto no GitHub
Não será detalhado aqui, mas é algo interessante para olhar.

### Criação de projetos
- Seleciona pasta no computador para conter um projeto, que pode ser sincronizada no GitHub
<https://www.coursera.org/learn/data-scientists-tools/lecture/2o9zr/projects-in-r>

### Controle de versão
<https://www.coursera.org/learn/data-scientists-tools/lecture/PjlHw/version-control>

### GitHub e Git
<https://www.coursera.org/learn/data-scientists-tools/lecture/VOh24/github-and-git>

### Projetos sob controle de versões
<https://www.coursera.org/learn/data-scientists-tools/lecture/wbfrX/projects-under-version-control>


## R Markdown
Markdown é uma sintaxe de formatação simples para criar documento HTML, PDF ou Microsoft Word.

Para mais detalhes de uso, veja:

- <https://www.coursera.org/lecture/data-scientists-tools/r-markdown-134kE>,
- Curso [_Reproducible Templates for Analysis and Dissemination_ (Emory/Coursera)]( www.coursera.org/learn/reproducible-templates-analysis)
- Livros: [_R Markdown: The Definitive Guide_](https://bookdown.org/yihui/rmarkdown/) e [_R Markdown Cookbook_](https://bookdown.org/yihui/rmarkdown-cookbook)



### Uso do R Markdown
Quando você clicar no botão **Knit**, um documento será gerado, incluindo o conteúdo textual e os resultados dos _chunks_ com códigos em R embutidos no documento.

Você pode embutir um _chunk_ de código em R: 

1. abrindo com 3 acentos graves (\`) 
2. {r nome_do_pedaco},
3. código em R, 
4. e fechando com 3 acentos graves (\`)

Por exemplo:

````yaml
```{r cars} # Chamando esse _chunk_ com código de R como 'cars' `r ''`
head(cars) # Visualizando 6 linhas iniciais da base de dados 'cars'
summary(cars) # Resumindo base de dados 'cars'
```
````

output:

```{r cars}
head(cars) # Visualizando 6 linhas iniciais da base de dados 'cars'
summary(cars) # Resumindo base de dados 'cars'
```

Também, no topo do quadrante sup-esq, é possível criar clicando no ícone "+C" e selecionando "R" (ou apertando Ctrl + Alt + I).



### Incluindo Gráficos
Você pode incluir gráficos no documento usando `plot()` dentro do _chunk_ com código R. Além disso, o parâmetro `echo = FALSE` retira do PDF/HTML gerado o _chunk_ de código, gerando apenas, neste caso, a figura.

Por exemplo:

````yaml
```{r pressure, echo = FALSE}`r ''`
plot(pressure) # Gráfico da base de dados 'pressure'
```
````

output:

```{r pressure, echo=FALSE}
plot(pressure)
```

*Ao invés de escrever `echo = FALSE`, é possível alterar a configuração do _chunk_ após criá-lo:<br/>  
Ícone de Config > Output > Show output only


### Formatação no R Markdown

#### Bullets:
````yaml
- bullet 1
- bullet 2
- bullet 3
````

output:

- bullet 1
- bullet 2
- bullet 3


#### Formatação de texto:
````yaml
1. **negrito**
2. *itálico* ou _itálico_
3. link: <http://rmarkdown.rstudio.com>.
4. [link R Markdown](http://rmarkdown.rstudio.com)
5. destaque para `código em r`
````

output:

1. **negrito**
2. *itálico* ou _itálico_
3. link: <http://rmarkdown.rstudio.com>.
4. [link R Markdown](http://rmarkdown.rstudio.com)
5. destaque para `código em r`



#### Títulos de seções e subseções
````yaml
# Título - 1º Nível
## Título - 2º Nível
### Título - 3º Nível
````


### Quebra de texto
Ao terminar de escrever uma linha ou parágrafo, é necessário apertar \<Enter\> duas vezes. Caso aperta apenas uma vez, o R Markdown considerará que o texto continua na mesma linha:
```yaml
Não pula linha
Não pula linha

Pula linha

Pula linha

```

output:

Não pula linha
Não pula linha

Pula linha

Pula linha


### Escrita em LaTeX
Também é possível usar os códigos em LaTeX para escrever expressões matemáticas usando `$`:

```yaml
- Para incluir uma expressão LaTeX no meio do texto, como $\alpha + \beta + \gamma$,
usa-se cifrão (`$`) único em cada lado.
- Para destacar uma expressão, como $$\alpha + \beta + \gamma, \tag{1}$$ é necessário
colocar 2 cifrões (`$`) de cada lado da expressão, assim como no LaTeX.
```

output:

- Para incluir uma expressão em LaTeX no meio do texto, como $\alpha + \beta + \gamma$, usa-se cifrão (`$`) único em cada lado.
- Para destacar uma expressão, como $$\alpha + \beta + \gamma, \tag{1}$$ é necessário colocar 2 cifrões (`$`) de cada lado da expressão, assim como no LaTeX.


Para aprender a usar LaTeX:

- Curso [_LaTeX for Students, Engineers and Scientists_ (edX)](www.edx.org/course/latex-for-students-engineers-and-scientists-2) (é possível cursar sem pagar - _audit course_)


### Exportando documentos em outros formatos
No código inicial do .Rmd, é possível alterar o formato exportado pelo documento:

- para PDF: `output: pdf_document`
- para HTML: `output: html_document`


#### Templates para HTML
Existem diversos templates para documentos HTML e, para utilizá-los, é preciso instalar
o pacote `rmdsformats`

```
install.packages("rmdformats")
```

Após a instalação, teste:

- `output: rmdformats::material`
- `output: rmdformats::readthedown`
- `output: rmdformats::downcute`
- `output: rmdformats::robobook`
- `output: rmdformats::html_clean`
- `output: rmdformats::html_docco`

# Operações e Objetos no R
## Operações básicas
```{r}
# Soma
1 + 1
# Subtração
2 - 3
# Multiplicação
2 * 3
# Divisão
6 / 4
# Divisão Inteira
6 %/% 4
# Resto da Divisão
6 %% 4
# Potenciação
2 ^ 3
8 ^ (1 / 3)
```


## Objetos no R
 - <https://www.coursera.org/learn/r-programming/lecture/OS8hs/data-types-r-objects-and-attributes>
 
Para criar um objeto, atribuímos algo (neste caso, um valor) a um nome por meio do operador de atribuição `<-` ou `=`:
```{r}
obj1 <- 5
obj2 = 5 + 2
```

Note que ambos objetos foram criados e aparecem no quadrante superior/direito (_Environment_). Agora, podemos imprimir os seus valores executando o nome do objeto
```{r}
obj1
```
ou imprimindo explicitamente por meio da função `print()`:
```{r}
print(obj2)
```

Note que, podemos alterar um objeto atribuindo algo novo a ele:
```{r}
obj1 = obj2
obj1
```

Uma forma bastante utilizada para alteração de valor de um objeto é utilizando o próprio valor de objeto como base:
```{r}
obj1 = obj1 + 3
obj1
```
> Isto será especialmente relevante quando trabalharmos com repetições/loops.


É possível visualizar o tipo de objeto usando a função `class()`:
```{r}
class(obj1)
```

Logo, `obj1` é um número real. Há 5 tipos de classes de objetos "atômicos" (que contêm apenas 1 valor):

 - `character`: texto
 - `numeric`: número real
 - `integer`: número inteiro
 - `complex`: número complexo
 - `logical`: verdadeiro/falso (1 ou 0)
 
```{r}
num_real = 3
class(num_real)

num_inteiro = 3L # para número inteiro, usar sufixo L
class(num_inteiro)

texto = "Oi"
print(texto)
class(texto)

boolean = 2>1
print(boolean)
class(boolean)

boolean2 = T # poderia escrever TRUE 
print(boolean2)

boolean3 = F # poderia escrever FALSE
print(boolean3)
```

### Textos (_characters_/_strings_)
- Só será abordado um conteúdo bem básico para trabalhar com texto.
- Para mais conteúdo:
    - <https://www.coursera.org/learn/data-cleaning/lecture/drpnT/editing-text-variables>
    - <https://www.coursera.org/learn/data-cleaning/lecture/bNiON/regular-expressions-i>
    - <https://www.coursera.org/learn/data-cleaning/lecture/QvbWt/regular-expressions-ii>
- Para extrair parte de um texto, usamos a função `substr()`
```yaml
substr(x, start, stop)

x: a character vector.
start: integer. The first element to be replaced.
stop: integer. The last element to be replaced.
```

```{r}
substr("shampoo", 1, 3) # extraindo caracteres 1 a 3 do texto
substr(110521, 4, 6) # também pode ser feito em números (torn-se texto)
```
- Isto pode ser interessante, por exemplo, com códigos de localidades do IBGE:
```{r}
cod_distrito = 110001515 # Distrito de Filadélfia d'Oeste
substr(cod_distrito, 1, 7) # Município de Alta Floresta d'Oeste
substr(cod_distrito, 1, 2) # UF Rondônia
```
- Eventualmente, uma base de dados pode vir com os códigos de UF, município e distrito de forma separada e precisamos juntar os códigos:
```{r}
cod_uf = 11
cod_municipio = 15
cod_distrito = 15
```
- No entanto, como o código parcial do município veio como número, precisamos adicionar uma certa quantidade de zeros na frente para ficar com 5 caracteres e ficar no padrão do IBGE. Para fazer isso, usamos a função `sprintf()` com a formatação `fmt="%05d"` (número com 5 dígitos)
```yaml
sprintf(fmt, ...)

fmt: a character vector of format strings, each of up to 8192 bytes.
...	: values to be passed into fmt. Only logical, integer, real and character vectors are supported, but some coercion will be done. Up to 100.
```
```{r}
sprintf("%05d", cod_municipio)
```
- Agora, para juntar textos (podendo incluir números), usamos as funções `paste0()` e `paste()`. A diferença entre eles é que o `paste0()` não incluir um separador entre os textos, e o `paste()` inclui um separador (o padrão é um espaço):
```{r}
paste0(cod_uf, sprintf("%05d", cod_municipio), cod_distrito)
paste(cod_uf, sprintf("%05d", cod_municipio), cod_distrito)
```


### Datas e horários
- <https://www.coursera.org/learn/r-programming/lecture/yl7BO/dates-and-times>
- <https://www.coursera.org/learn/data-cleaning/lecture/0rohY/working-with-dates>
- R usa uma representação especial para datas e horários
- Datas são representadas na classe `Date`
    - São armazenadas internamente como _número de dias_ desde 1970-01-01
    - Para transformar um texto em uma data, usamos a função `as.Date()`
    
```{r}
x = as.Date("1970-01-01")
class(x)
x

unclass(x) # Dia 0
unclass(as.Date("1969-12-31")) # Dia -1
```

- Horários são representadas na classe `POSIXct` (apenas um _integer_ bem grande) ou `POSIXlt` (_lista_ guarda mais informações - dia da semana, dia do ano, mês, dia do mês)
     - São armazenadas internamente como _número de segundos_ desde:
        - **1970**-01-01, se `POSIXct`
        - **1900**-01-01, se `POSIXlt`

```{r}
## POSIXct
x = as.POSIXct("1970-01-01")
x
class(x)
unclass(x) # Nº de segundos desde 1970-01-01 (dado fuso horário)


## POSIXlt
p = as.POSIXlt("1970-01-01")
class(p)
unclass(p) # informações desde 1900
```


### Expressões lógicas/booleanas
São expressões que retornam o valor Verdadeiro ou Falso:
```{r}
class(TRUE)
class(FALSE)

T + F + T + F + F # soma de 1's (TRUE) e 0's (FALSE)

2 < 20
19 >= 19

100 == 10**2
100 != 20*5
```

É possível escrever expressões compostas utilizando `|` (ou) e `&` (e):
```{r}
x = 20
x < 0 | x**2 > 100
x < 0 & x**2 > 100
```

> **Tabela de Precedência de Operadores**
> 
> - Nível 6 - exponenciação: `**`
> - Nível 5 - multiplicação: `*`, `/`, `%/%`, `%%`
> - Nível 4 - adição: `+`, `-`
> - Nível 3 - relacional: `==`, `!=`, `<=`, `>=`, `>`, `<`
> - Nível 2 - lógico: `&` (e)
> - Nível 1 - lógico: `|` (ou)


### Vetores
- <https://www.coursera.org/learn/r-programming/lecture/wkAHm/data-types-vectors-and-lists>

Depois das 5 classes de objetos apresentadas acima, as mais básicas são os vetores e as listas, que possuem mais de um elemento dentro do objeto. Um vetor necessariamente exige que os elementos sejam da mesma classe. Podemos criar um vetor usando a função `c()` e incluindo os valores separados por `,`:
```{r}
x = c(0.5, 0.6) # numeric
x = c(TRUE, FALSE) # logical
x = c("a", "b", "c") # character
x = 9:12 # integer (é igual a c(9, 10, 11, 12))
x = c(1+0i, 2+4i) # complex
```


Também é possível criar um vetor "em branco" usando a função `vector()` e definindo a classe dos seus elementos junto de seu tamanho:

```yaml
vector(mode = "logical", length = 0)

mode: character string naming an atomic mode or "list" or "expression" or (except for vector) "any". Currently, is.vector() allows any type (see typeof) for mode, and when mode is not "any", is.vector(x, mode) is almost the same as typeof(x) == mode.
length: a non-negative integer specifying the desired length. For a long vector, i.e., length > .Machine$integer.max, it has to be of type "double". Supplying an argument of length other than one is an error
```

```{r}
x = vector(mode="numeric", length=10)
x
```

Se utilizarmos a função `c()` com elementos de classes diferentes, o R transforma a classe do objeto para o "mais geral":
```{r}
y = c(1.7, "a") # (numeric, character) -> character
class(y)

y = c(FALSE, 0.75) # (logical, numeric) -> numeric
class(y)

y = c("a", TRUE) # (character, logical) -> character
class(y)
```

> **Note que**:
>
> character $>$ complex $>$ numeric $>$ integer $>$ logical

Também podemos forçar a mudança de classe de objeto para a classe "menos geral", o que acaba transformando:

- os elementos "mais gerais" em missing values (NA's),
```{r}
as.numeric(c(1.7, "a")) # (numeric, character)
as.logical(c("a", TRUE)) # (character, logical) 
```
- [exceção] de _character_ com número (por exemplo, "9") para _numeric_: torna-se _numeric_
```{r}
as.numeric(c(1.7, "9")) # (numeric, character número)
```
- [exceção] de _numeric_ diferente de zero para _logical_: torna-se TRUE
- [exceção] de _numeric_ igual a zero para _logical_: torna-se FALSE
```{r}
as.logical(c(FALSE, 0.75, -10)) # (logical, numeric > 0, numeric < 0)
as.logical(c(TRUE, 0)) # (logical, numeric zero) 
```
- [exceção] de _character_ lógico ("TRUE", "T", "FALSE", "F") para _logical_: torna-se _logical_ ("0" e "1" tornam-se NA)
```{r}
as.logical(c("T", "FALSE", "1", TRUE)) # (character TRUE/FALSE, logical) 
```

### Listas
Já uma lista permite que os valores pertençam a classes distintas, inclusive podendo conter um vetor como elemento. Ela pode ser criada por meio da função `list()`:
```{r}
x = list(1, "a", TRUE, 1+4i, c(0.5, 0.6))
x
class(x)
```


### Matrizes
Matrizes são vetores (e, portanto, possuem elementos de mesma classe) com atributo de _dimensão_ (nº linhas por nº colunas). Uma matriz pode ser criada usando a função `matrix()`:

```yaml
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, ...)

data: an optional data vector (including a list or expression vector). Non-atomic classed R objects are coerced by as.vector and all attributes discarded.
nrow: the desired number of rows.
ncol: the desired number of columns.
byrow: logical. If FALSE (the default) the matrix is filled by columns, otherwise the matrix is filled by rows.
```

```{r}
m = matrix(nrow=2, ncol=3)
m
```

É possível construir uma matriz "preenchida" informando os seus (nº linhas $\times$ nº colunas) valores por meio de um vetor. Os elementos deste vetor preenchem primeiro todas linhas de uma coluna para, depois, preencher a próxima coluna (_column-wise_):
```{r}
m = matrix(1:6, nrow=2, ncol=3)
m
```

> **ATENÇÃO**: No Python, você informa os valores da matriz por linha (_row-wise_).

Outra maneira de criar matrizes é juntando vetores em colunas (_column-binding_) ou em linhas (_row-binding_), usando as funções `cbind()` e `rbind()`, respectivamente:

```yaml
cbind(...)
rbind(...)

... : (generalized) vectors or matrices. These can be given as named arguments. Other R objects may be coerced as appropriate, or S4 methods may be used: see sections ‘Details’ and ‘Value’. (For the "data.frame" method of cbind these can be further arguments to data.frame such as stringsAsFactors.)
```

```{r}
x = 1:3
y = 10:12

cbind(x, y)
rbind(x, y)
```


### Fatores
- <https://www.coursera.org/learn/r-programming/lecture/Eidkq/data-types-factors>

- _Factor_ é uma classe de objeto que representa uma variável categórica, em que cada possível valor é considerado uma categoria/nível (_level_) distinto.
- Por exemplo, ao usar factor em uma variável de sexo/gênero, os valores "masculino" e "feminino" podem ser considerados como níveis (_levels_) 1 e 2, por exemplo.
- Isso é especialmente interessante em regressões (via `lm()` ou `glm()`), pois
    - quando esse _factor_ é colocado como variável explicativa, o R já considera cada nível como uma _dummy_, e
    - para evitar multicolinearidade perfeita, retira-se automaticamente o 1º nível (no exemplo, portanto, manteria apenas uma _dummy_ de "feminino" na regressão).
- Para criar um _factor_, usa-se a função `factor()`
```yaml
factor(x = character(), levels, ...)

x: a vector of data, usually taking a small number of distinct values.
levels: an optional vector of the unique values (as character strings) that x might have taken. The default is the unique set of values taken by as.character(x), sorted into increasing order of x. Note that this set can be specified as smaller than sort(unique(x)).
```

```{r}
texto = c("yes", "yes", "no", "maybe", "yes", "no")
x = factor(texto)
x

unclass(x) # Visualizar como o factor é representado em níveis
```

- Note que, quando transformamos o vetor `texto` em factor, considerou automaticamente que "maybe" é o 1º nível, "no" é o 2º nível e "yes" é o 3º nível.
- Eventualmente, queremos definir "yes" como 1º nível do _factor_ para que, por exemplo, seja o nível desconsiderado numa regressão (para evitar multicolinearidade perfeita).
- Para isto, podemos usar incluir o argumento `levels = ...` quando transformar um vetor em _factor_ usando a função `factor`
- Ou, também, utilizar a função `relevel()` em um _factor_ existente

```yaml
relevel(x, ref, ...)

x: an unordered factor.
ref: the reference level, typically a string.
```

```{r}
y = factor(texto, levels=c("yes", "no", "maybe"))
unclass(y)

x = relevel(x, ref="yes")
unclass(x)
```


### Data frames
- <https://www.coursera.org/learn/r-programming/lecture/kz1Lh/data-types-data-frames>

- É um tipo especial de lista, em que cada elemento da lista possui o mesmo tamanho
- Cada elemento da lista pode ser entendida como uma coluna de uma base de dados
- Diferente de matrizes, cada elemento de um _data frame_ pode ser de uma classe diferente 
- Normalmente é criada automaticamente ao carregarmos uma base de dados em um objeto via `read.table()` ou `read.csv()`
- Mas também pode ser criada manualmente via `data.frame()`

```yaml
data.frame(..., stringsAsFactors = FALSE)

... : these arguments are of either the form value or tag = value. Component names are created based on the tag (if present) or the deparsed argument itself.
stringsAsFactors: logical: should character vectors be converted to factors?.
```

```{r}
x = data.frame(foo=1:4, bar=c(T, T, F, F))
x
nrow(x) # Número de linhas de x
ncol(x) # Número de colunas de x
```


#### Importando data frames
- <https://www.coursera.org/learn/r-programming/lecture/bQ5B9/reading-tabular-data>
- Para leitura de base de dados, as funções mais utilizadas são `read.table()` e `read.csv()`
- O `read.table()` tem o seguinte argumentos (que também podem ser visto nas demais funções de leitura de base de dados):
    - `file`: caminho/endereço do arquivo, incluindo a sua extensão
    - `header`: `TRUE` ou `FALSE` indicando se a 1ª linha da base de dados é um cabeçalho
    - `sep`: indica como as colunas são separadas
    - `stringAsFactors`: `TRUE` ou `FALSE` se as variáveis de texto devem ser transformadas em _factors_.
```r
data = read.table("foo.txt")
data = read.table("foo.csv")
```
- Note que, caso você não tenha definido o diretório de trabalho, é necessário informar o caminho/endereço inteiro do arquivo que você quer importar:
```r
data = read.table("C:/Users/fhnis/OneDrive/FEA-RP/foo.csv")
```
- `read.csv()` é igual ao `read.table()`, mas considera como padrão que o separador de colunas é a vírgula (`sep = ","`)
- Para gravar uma base de dados, utilizamos as funções `write.csv()` e `write.table()`, nas quais informamos um data frame e o nome do arquivo (junto de sua extensão).


#### Importando em outros formatos
- Para abrir arquivos em Excel, nos formatos .xls e xlsx, é necessário utilizar o pacote `xlsx` (<https://cran.r-project.org/web/packages/xlsx/xlsx.pdf>)
```r
read.xlsx("foo.xlsx", sheetIndex=1) # Lendo a 1ª aba do arquivo Excel
```
- Para abrir arquivos de SPSS, Stata e SAS, é necessário utilizar o pacote `haven` e, respectivamente, as funções `read_spss()`, `read_dta()` e `read_sas()`

> Note que no padrão do R, o separador decimal é o ponto (`.`), enquanto no padrão brasileiro usa-se vírgula.
>
> Isso pode gerar importação equivocada dos valores, caso o .csv ou o .xlsx tenham sido gerados no padrão brasileiro.
>
> Para contornar este problema, utilize as funções de importação `read.csv2()` e `read.xlsx2()` para que os dados sejam lidos a partir do padrão brasileiro e os dados sejam importados corretamente


## Subconjuntos de objetos
- <https://www.coursera.org/learn/r-programming/lecture/JDoLX/subsetting-basics>
- Há 3 operadores básicos para extrair subconjuntos de objetos no R:
    - `[]`: retorna um "sub-objeto" da mesma classe do objeto original
    - `[[]]`: usado para extrair elementos de uma lista ou data frame, em que o "sub-objeto" não é necessariamente da mesma classe do objeto original
    - `$`: usado para extrair elemento de uma lista ou data frame pelo nome


### Subconjunto de vetores
```{r}
x = c(1, 2, 3, 3, 4, 1)
x[1] # extraindo o 1º elemento de x
x[1:4] # extraindo do 1º ao 4º elemento de x
```

> **ATENÇÃO**: Diferente do Python, em que a numeração se inicia no 0, a numeração dos elementos no R se inicia no 1.

- Note que, ao fazer uma expressão lógica com um vetor, obtemos um outro vetor, chamado de _índice lógico_
```{r}
x > 1
```
- Usando o operador `[]`, podemos extrair um subconjunto do vetor `x` usando uma condição. Por exemplo, vamos extrair apenas valores maiores do que 1:
```{r}
x[x > 1]
x[c(F, T, T, T, T, F)] # Equivalente ao x[x > 1] - Extrair apenas TRUE's
```

### Subconjunto de listas
- <https://www.coursera.org/learn/r-programming/lecture/hVKHm/subsetting-lists>
- Note que, diferente do vetor, para acessar um valor/elemento de uma lista é necessário utilizar `[[]]` com o número da posição do elemento da lista
```{r}
x = list(foo=1:4, bar=0.6)
x

x[1] # retorna uma lista $foo
class(x[1])

x[[1]] # retorna um vetor de classe numeric
class(x[[1]])
```
- Se quiser acessar um elemento dentro deste elemento da lista, precisa ser seguido por `[]`
```{r}
x[[1]][2]
x[[2]][1]
```
- Também podemos usar o nome para extrair um subconjunto do objeto
```{r}
x[["foo"]]
x$foo
```


### Subconjunto de matrizes e de data frames
- <https://www.coursera.org/learn/r-programming/lecture/4gSc1/subsetting-matrices>
- Para extrair um pedaço de uma matriz ou de um data frame, indicamos as linhas e as colunas dentro do operador `[]`
```{r}
x = matrix(1:6, 2, 3)
x
x[1, 2] # linha 1 e coluna 2 da matriz x
x[1:2, 2:3] # linha 1 e colunas 2 e 3 da matriz x
```
- Podemos selecionar linhas ou colunas inteiras ao não informar os índice:
```{r}
x[1, ] # linha 1 e todas colunas
x[, 2] # todas linhas e coluna 2
```
- Note que, quando o subconjunto é um valor único ou um vetor, o objeto retornado deixa de ser uma matriz. Podemos forçar a se manter como matriz usando o argumento `drop= FALSE`
```{r}
x[1, 2, drop = FALSE]
```

### Removendo valores ausentes (_missing values_ - `NA`)
- <https://www.coursera.org/learn/r-programming/lecture/Qy8bH/subsetting-removing-missing-values>
- Remover dados faltantes é uma ação comum quando manipulamos bases de dados
- Para verificar quais dados são `NA`, usa-se a função `is.na()`
```{r}
x = c(1, 2, NA, 4, NA, NA)
is.na(x)

sum(is.na(x)) # qtd de missing values
```
- Relembre que o operador `!` nega uma expressão e, portanto, `!is.na()` nos resulta os elementos que **não** são ausentes
```{r}
x[ !is.na(x) ]
```


## Operações vetoriais/matriciais
- <https://www.coursera.org/learn/r-programming/lecture/nobfZ/vectorized-operations>
- Ao utilizar as operações matemáticas convencionais em vetores, cada elemento é operacionalizado com o elemento na mesma posição do outro vetor
```{r}
x = 1:4
y = 6:9

x + y # soma de cada elemento na mesma posição
x + 2 # soma de de cada elemento com um mesmo escalar
x * y # multiplicação de cada elemento na mesma posição
x / y # divisão de cada elemento na mesma posição
```
- Para fazer o produto vetorial usa-se `%*%`. Por padrão, o R considera que o 1º vetor é um vetor-linha e o 2º é um vetor-coluna.
```{r}
x %*% y
```
- Para transpor um vetor ou uma matriz, pode-se transformar em um vetor linha ou coluna via `matrix()`, ou é possível transpor usando  a função `t()`.
```{r}
x %*% t(y) # x vetor-coluna / y vetor-linha

# Transformando vetores em objetos matriz
x_col = matrix(x, ncol=1)
x_col

y_lin = matrix(y, nrow=1)
y_lin

x_col %*% y_lin
```
- O mesmo é válido para matrizes:
```{r}
x = matrix(1:4, nrow=2, ncol=2)
y = matrix(rep(10, 4), nrow=2, ncol=2)

x + y # Soma de elementos na mesma posição
x + 2 # Soma de cada elemento da matriz com um mesmo escalar
x * y # Multiplicação de elementos na mesma posição

x %*% y # Multplicação matricial
```

> Note que essas operações matemáticas são equivalentes às realizadas apenas quando as matrizes são transformadas em `numpy.array` no Python.


# Estruturas de controle
- Estruturas de controle no R permitem o controle do fluxo do programa

## Estrutura condicional (`if`/`else`)
- <https://www.coursera.org/learn/r-programming/lecture/PDOOA/control-structures-if-else>
```{r}
x = 5
if (x > 10) {
    y = 10
    print("caso x > 10")
} else if (x > 0) {
    y = 5
    print("caso 10 >= x > 0")
} else {
    y = 0
    print("caso x >= 0")
}
y
```

- Essa mesma estrutura também pode ser utilizada para atribuir valor a um objeto
```{r}
x = 5
y = if (x > 10) {
    10
} else if (x > 0) {
    5
} else {
    0
}
y
```
- mas existem funções mais práticas para atribuir valor a um objeto a partir de uma condição:
    - função `ifelse()` (útil para 2 possíveis valores)
    
```yaml
ifelse(test, yes, no)

test: an object which can be coerced to logical mode.
yes: return values for true elements of test.
no: return values for false elements of test.
```

```{r}
x = 5
y = ifelse(x > 10, yes=10, no=5)
y
```

- função `case_when()` do pacote `dplyr` (útil para mais do que 2 possíveis valores)

```yaml
case_when(...)

... : A sequence of two-sided formulas. The left hand side (LHS) determines which values match this case. The right hand side (RHS) provides the replacement value.
```
    
```{r}
x = 5
y = dplyr::case_when(
    x > 10 ~ 10,
    x >  0 ~  5,
    TRUE   ~  0  # Else
)
y
```

- note que, no `case_when()`, se não deixarmos claros todas os possíveis casos e, por acaso, cair num caso não declarado, a função retorna o valor `NA`
    
```{r}
x = 5
y = dplyr::case_when(
    x > 10 ~ 10,
    x <= 0 ~  0
)
y
```

## Estrutura de repetição/loop (`for`)
- <https://www.coursera.org/learn/r-programming/lecture/baydC/control-structures-for-loops>
- A repetição usando `for` exige que você insira um vetor e defina um nome para a variável de indicação
```{r}
for(i in 3:7) {
    print(i)
}
```
- Acima, nomeamos a variável de indicação como `i` e inserimos um vetor de números inteiros entre 3 e 7.
- A cada _iteração_ (loop) é atribuído ao `i` um valor do vetor `3:7`, até "acabarem" todos os elementos do vetor

### Construção de vetor de sequência
- Uma forma interessante de construir um vetor/sequência é utilizando a função `seq()`

```yaml
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, ...)

from, to: the starting and (maximal) end values of the sequence. Of length 1 unless just from is supplied as an unnamed argument.
by:	number, increment of the sequence.
length.out: desired length of the sequence. A non-negative number, which for seq and seq.int will be rounded up if fractional.
```
- Note que todos argumentos já possuem valores pré-definidos, então podemos montar sequências de maneiras distintas.
- Considerando o preenchimento dos argumentos `from` e `to`, podemos:
    - definir `by` para dar um valor de quanto varia entre um elemento e outro, ou
    - definir `length.out` para informar a quantidade de elementos que terá na sequência
```{r}
seq(from=0, to=10, by=2)
seq(from=0, to=10, length.out=5)
```

- Sequências são interessantes para incluir em repetições utilizando `for`
```{r}
sequencia = seq(1, 5, length.out=11)
sequencia

for (val in sequencia) {
    print(val^2)
}
```

## Estrutura de repetição/loop (`while`)
- <https://www.coursera.org/learn/r-programming/lecture/WWXg6/control-structures-while-loops>
- Diferente do `for`, a repetição via `while` exige que uma variável de indicação já esteja criada previamente antes de entrar no loop
- Isto se dá, pois os loops (inclusive o primeiro) só serão realizados se uma condição for verdadeira
- Note que, por não seguir uma sequência de elemento dentro de um vetor (como no `for`), **é necessário que a variável indicadora seja atualizada a cada iteração para que a repetição não seja feita infinitamente**.
- Um forma comum de executar o `while` é definindo a variável de indicação como um contador, isto é, ir contando a quantidade de loops realizados e parar em uma determinada quantidade
```{r}
contador = 0

while (contador <= 10) {
    print(contador)
    contador = contador + 1
}
```
- Uma outra maneira é, ao invés de aumentar em uma unidade por loop, a variável indicadora ser calculada e ela convergir ou ultrapassar algum limite. No exemplo abaixo, a cada loop da `distancia` diminuirá pela metade e irá parar num valor bem próximo de 0 (algum valor menor do que $10^{-3}$)
```{r}
distancia = 10
tolerancia = 1e-3
tolerancia

while (distancia > tolerancia) {
    distancia = distancia / 2
}

distancia
```


## Repetições encaixadas
- É comum o uso de uma estrutura de repetição dentro de outra estrutura de repetição.
- Como exemplo, será criada uma matriz vazia e esta será preenchida com a tabela de tabuada

```{r}
tabuada = matrix(NA, 10, 10)
tabuada

# Preenchimento da matriz de tabuada
for (linha in 1:10) {
    for (coluna in 1:10) {
        tabuada[linha, coluna] = linha * coluna
    }
}
tabuada
```


# Simulação
<!-- Funções para distribuições de probabilidade no R: -->

<!-- - `rnorm`: gera amostra aleatória normal, dada uma média e dado um desvio padrão -->
<!-- - `dnorm`: avalia a densidade de probabilidade normal (dada média e desvio padrão) em um ponto (ou num vetor de pontos) -->
<!-- - `pnorm`: avalia a função de distribuição acumulada para uma distribuição normal -->
<!-- - `rpois`: gera amostra aleatória Poisson, dada uma taxa -->

## Geração de números aleatórios
Para cada função de distribuição de probabilidade (Normal, Poisson, Binomial, Exponencial, Gamma, etc.), há normalmente quatro funções associadas que utilizam os seguintes prefixos:

- `d`: densidade
- `r`: geração de números aleatórios
- `p`: distribuição acumulada
- `q`: quantil

Portanto, para a distribuição normal, temos as seguintes funções:
```yaml
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

x, q: vector of quantiles.
p: vector of probabilities.
n: number of observations. If length(n) > 1, the length is taken to be the number required.
mean: vector of means.
sd: vector of standard deviations.
log, log.p: logical; if TRUE, probabilities p are given as log(p).
lower.tail: logical; if TRUE (default), probabilities are P[X ≤ x] otherwise, P[X > x].
```
- Para reproduzir resultados, podemos usar a função `set.seed()` que, dado um número inteiro, faz com que a função `rnorm()` sempre gere os mesmos número aleatórios.
```{r}
# definindo seed
set.seed(2022)
rnorm(5)

# sem definir seed
rnorm(5)

# definindo seed
set.seed(2022)
rnorm(5)
```


### Simulando um modelo linear
- <https://www.coursera.org/learn/r-programming/lecture/u7in9/simulation-simulating-a-linear-model>
- Suponha o modelo linear:
$$ y = \beta_0 + \beta_1 x + \varepsilon, \qquad \varepsilon \sim N(0, 2^2) $$
- Assuma também que $x \sim N(0, 1^2), \beta_0 = 0.5$ e $\beta_1 = 2$:
```{r}
set.seed(2022)
x = rnorm(100)
e = rnorm(100, 0, 2)

y = 0.5 + 2*x + e
head(y, 10)

summary(y) # resumo da variável y

plot(x, y) # Figura de x contra y
```


## Amostragem aleatória
- <https://www.coursera.org/learn/r-programming/lecture/ykXUb/simulation-random-sampling>
- Para fazer uma amostragem a partir de um dado vetor, usamos a função `sample()`
```yaml
sample(x, size, replace = FALSE, prob = NULL)

x: either a vector of one or more elements from which to choose, or a positive integer. See ‘Details.’
n: a positive number, the number of items to choose from.
size: a non-negative integer giving the number of items to choose.
replace: should sampling be with replacement?
prob: a vector of probability weights for obtaining the elements of the vector being sampled.
```
```{r}
set.seed(2022)
sample(1:10, 4) # Amostragem definindo seed

sample(1:10, 4) # Amostragem sem definir seed

sample(letters, 5) # Amostragem de 5 letras

sample(1:10) # Permutação (amostra mesma qtd de elementos do vetor)

sample(1:10, replace = TRUE) # Amostragem com reposição
```
- Note que, por padrão, a função `sample()` amostra sem reposição.


# Criando funções
- <https://www.coursera.org/learn/r-programming/lecture/BM3dR/your-first-r-function>
- Para criar uma função, usamos a função `function(){}`:
    - dentro dos parêntesis `()`, incluímos nomes de variáveis arbitrárias (argumentos/inputs) que serão utilizadas pela função para fazer cálculos
    - dentro das chaves `{}`, usamos os nomes das variáveis arbitrárias definidas dentro do parêntesis para fazer cálculos e retornar um output (último valor dentro das chaves)
- Como exemplo, criaremos uma função que pega 2 números como inputs e retorna sua soma
```{r}
soma = function(a, b) {
    a + b
}
```
- Ao atribuir a função ao objeto `soma` não geramos resultados. Para fazer isso, usamos a função `soma()` inserindo 2 números como inputs:
```{r}
soma(10, 4)
```
- Note que as variáveis arbitrárias `a` e `b` são utilizadas apenas dentro da função
```r
> a
Error: object 'a' not found
```

- Note que podemos inserir um valor padrão para um argumento de função. Como exemplo, criaremos uma função que retorna todos elementos acima de `n` de um vetor dado:
```{r}
vetor = 1:20
above = function(x, n = 10) {
    x[x > n]
}

above(vetor) # todos acima do valor padrão 10
above(vetor, 14) # todos acima de 14
```

# Resumindo dados
## Estatísticas básicas
- Soma: `sum(..., na.rm = FALSE)`
```{r}
x = c(1, 4, 5, 2, 8, 2, 4, 7, 8, 0, 2, 3, 5, 7, 4, 4, 2, 5, 2, 6)
sum(x)
```
- Média: `mean(x, trim = 0, na.rm = FALSE, ...)`
```{r}
mean(x)
```
- Desvio Padrão: `sd(x, na.rm = FALSE)`
```{r}
sd(x)
```
- Quantis: `quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE, ...)`
```{r}
# Mínimo, 1º Quartil, Mediana, 3º Quartil e Máximo
quantile(x, probs=c(0, .25, .5, .75, 1))
```
- Note que, se houve valores ausentes (`NA`), a função retorna `NA` por padrão. Para excluir os valores ausentes, precisamos definir o argumento `na.rm = TRUE`:
```{r}
x = c(1, 4, 5, 2, NA, 2, 4, 7, 8, 0, 2, 3, NA, 7, 4, 4, 2, 5, 2, 6)
mean(x) # Sem excluir valores ausentes
mean(x, na.rm=TRUE) # Excluindo valores ausentes
```


## Família de funções _apply_
Veremos uma família de funções _apply_ que permitem executar comandos em loop de maneira compacta:

- `lapply`: loop sobre uma lista e avalia uma função em cada elemento
    - função auxiliar `split` é útil ao ser utilizada em conjunto da `lapply`
- `sapply`: mesmo que o `lapply`, mas simplifica o resultado
- `apply`: aplica uma função sobre as margens de um array
- `tapply`: aplica uma função sobre subconjuntos de um vetor
- `mapply`: versão multivariada do `lapply`



### Função `lapply()`
- <https://www.coursera.org/learn/r-programming/lecture/t5iuo/loop-functions-lapply>
- `lapply` usa três argumentos: uma **lista**, o nome de uma função e outros argumentos (incluindo os da função inserida)
```yaml
lapply(X, FUN, ...)

X: a vector (atomic or list) or an expression object. Other objects (including classed objects) will be coerced by base::as.list.
FUN: the function to be applied to each element of X: see ‘Details’. In the case of functions like +, %*%, the function name must be backquoted or quoted.
... : optional arguments to FUN.
```
```{r}
x = list(a=1:5, b=rnorm(10))
lapply(x, mean)
```

- `lapply` transforma o objeto em uma _lista_ (caso o input não seja), em que cada elemento possui um único elemento
```{r}
nada = function(x) {
    x # Retorna o próprio input
}

x = 1:4 # Vetor de 1 a 4 (será transformado em lista no lapply)
lapply(x, nada)
```

- `lapply` sempre retorna uma _lista_ como output. Como exemplo, usaremos a função `runif(n, min = 0, max = 1)` para gerar `n` números aleatórios:
```{r}
runif(2) # Gerando 2 números aleatórios

x = 1:4 # Vetor de 1 a 4 (será transformado em lista no lapply)
lapply(x, runif, min=0, max=10) # 2 últimos argumentos são do runif
```
- Podemos usar funções _anônimas_ diretamente no `lapply`. Como exemplo, criaremos uma função que nos dá a 1ª coluna de uma matriz ou data frame:
```{r}
# Criando lista com 2 matrizes
x = list(a=matrix(1:4, 2, 2), b=matrix(1:6, 3, 2))
x

# Pegando as primeiras colunas de cada matriz da lista x
lapply(x, function(matriz){matriz[, 1]})
```


### Função `sapply()`
Similar ao `lapply`, mas `sapply` tenta simplificar o output:

- Se o resultado for uma lista em que todo elemento tem comprimento 1 (tem apenas um elemento também), retorna um vetor
```{r}
x = list(a=1:4, b=rnorm(10), c=rnorm(20, 1), d=rnorm(100, 5))
x

lapply(x, mean) # retorna uma lista
sapply(x, mean) # retorna um vetor
```
- Se o resultado for uma lista em que cada elemento tem mesmo comprimento ($>1$), retorna uma matriz
```{r}
x = 1:4

tabuada = function(a) {
    a * 1:10
}
tabuada(2)

lapply(x, tabuada) # retorna uma lista
sapply(x, tabuada) # retorna uma matrix
```

- Caso contrário, retorna uma lista (assim como `lapply`)
```{r}
x = 1:4
sapply(x, runif, min=0, max=10) # retorna igual ao lapply
```


### Função `apply()`
- <https://www.coursera.org/learn/r-programming/lecture/IUUhK/loop-functions-apply>
- Usado para avaliar, por meio de uma função, margens de um array
- Frequentemente é utilizado para aplicar uma função a linhas ou a colunas de uma matriz
- Não é mais rápido do que escrever um loop, mas funciona em uma única linha
```yaml
apply(X, MARGIN, FUN, ...)

X: an array, including a matrix.MARGIN: a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. Where X has named dimnames, it can be a character vector selecting dimension names.
FUN: the function to be applied: see ‘Details’. In the case of functions like +, %*%, etc., the function name must be backquoted or quoted.
... : optional arguments to FUN.
```
```{r}
x = matrix(1:20, 5, 4)
x

apply(x, 1, mean) # médias das linhas
apply(x, 2, mean) # médias das colunas
```
- Há funções pré-definidas que aplicam `apply` com soma e com média:
    - `rowSums = apply(x, 1, sum)`
    - `rowMeans = apply(x, 1, mean)`
    - `colSums = apply(x, 2, sum)`
    - `colMeans = apply(x, 2, mean)`
- Podemos também calcular os quantis de uma matriz usando a função `quantile()`
```yaml
quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE,
         names = TRUE, type = 7, digits = 7, ...)

x: numeric vector whose sample quantiles are wanted, or an object of a class for which a method has been defined (see also ‘details’). NA and NaN values are not allowed in numeric vectors unless na.rm is TRUE.
probs: numeric vector of probabilities with values in [0,1]. (Values up to 2e-14 outside that range are accepted and moved to the nearby endpoint.)
na.rm: logical; if true, any NA and NaN's are removed from x before the quantiles are computed.
```
```{r}
x = matrix(1:50, 10, 5) # matriz 20x10 - 200 números ~ N(0, 1)
apply(x, 2, quantile, probs=c(0, .25, .5, .75, 1))
```


### Função `mapply()`
- <https://www.coursera.org/learn/r-programming/lecture/EBnAr/loop-functions-mapply>
- Versão multivariada de apply. Antes incluímos apenas um vetor `x` para aplicar na função, agora iremos incluir 2 ou mais vetores.
- Por isso, `mapply` tem como primeiro argumento a função `FUN`, já que podemos ter diversos vetores como input
```yaml
mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,
       USE.NAMES = TRUE)

FUN: function to apply, found via match.fun.
...	: arguments to vectorize over (vectors or lists of strictly positive length, or all of zero length). See also ‘Details’.
MoreArgs: a list of other arguments to FUN.
SIMPLIFY: logical or character string; attempt to reduce the result to a vector, matrix or higher dimensional array; see the simplify argument of sapply.
```
- Note que, agora, precisamos incluir os argumento da função por meio de uma _lista_ no argumento `MoreArgs`
- Como exemplo, usaremos a função `rep(x, n)` que cria um vetor com o objeto `x` repetido `n` vezes (**são necessário 2 argumentos**)
```{r}
rep(1, 5)

# Criando uma lista com números repetidos
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

# Podemos fazer o mesmo usando a função mapply
mapply(rep, 1:4, 4:1)
```


### Função `tapply()`
- <https://www.coursera.org/learn/r-programming/lecture/w98BR/loop-functions-tapply>
- Função `tapply` é uma versão do `apply` em que há um output para cada grupo/categoria.
- Para usá-la, precisamos inserir tanto um vetor de valores `x`, quanto um vetor de índices dos grupos/categoria.
```yaml
tapply(X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)

X: an R object for which a split method exists. Typically vector-like, allowing subsetting with [.
INDEX: a list of one or more factors, each of same length as X. The elements are coerced to factors by as.factor.
FUN: a function (or name of a function) to be applied, or NULL. In the case of functions like +, %*%, etc., the function name must be backquoted or quoted. If FUN is NULL, tapply returns a vector which can be used to subscript the multi-way array tapply normally produces.
```
- Como exemplo, calcularemos a média de `x` para 4 grupos
```{r}
x = rnorm(20)
grupos = rep(c("a", "b", "c", "d"), 5)
cbind(x, grupos)

tapply(x, grupos, mean)
```


### Função `split()`
- <https://www.coursera.org/learn/r-programming/lecture/2VYGZ/loop-functions-split>
- É parecido com o `tapply`, mas ao invés de aplicar uma função, retorna apenas uma lista com elementos correspondentes aos grupos e seus valores
```{r}
split(x, grupos)
```
- Depois de separar em uma lista, podemos usar o `lapply` ou `sapply` (é como se fosse aplicar o `tapply`, mas em 2 etapas)
```{r}
sapply(split(x, grupos), mean)
```

## Resumindo _data frames_
- <https://www.coursera.org/learn/data-cleaning/lecture/e5qVi/summarizing-data>
- Para esta seção, usaremos a base de dados `starwars` do pacote `dplyr`
- Verificaremos o **dimensões** da base com `dim()` e visualizaremos as 6 **primeiras** e **últimas** linhas da base via `head()` e `tail()`, respectivamente.
```{r}
data() # lista de base de dados presentes no R
bd_air = airquality # Atribuindo a base a um outro objeto

dim(bd_air) # Verificar tamanho da base (linhas x colunas)
head(bd_air) # Visualizando as 6 primeiras linhas
tail(bd_air) # Visualizando as 6 últimas linhas
```
- Usando `str()`, podemos visualizar a **estrutura** da base:
    - todas a variáveis (colunas),
    - a classe de cada uma delas e
    - algumas de suas observações.
```{r}
str(bd_air)
```
- Podemos ver as **categorias/valores únicos** para cada variável combinando `sapply()` e `unique()`
```{r}
apply(bd_air, 2, unique)
```
- Podemos verificar o **número de NA's** em cada coluna usando `apply()` com `sum` (ou também `colSums()`) na base de dados com `is.na()` (transforma a base de dados em TRUE/FALSE se for ou não `NA`)
```{r}
head( is.na(bd_air) ) # 6 primeiras linhas aplicando is.na()
apply(is.na(bd_air), 2, sum) # somando cada coluna de TRUE/FALSE
```

- Para fazer um **resumo** de todas as variáveis da base, podemos usar a função `summary()` que, para variáveis numéricas, calcula a média e os quartis, e mostra a quantidade de `NA`.
```{r}
summary(bd_air)
```
- Também podemos calcular os **quantis** via `quantile()`
```{r}
quantile(bd_air$Ozone, probs=c(0, .25, .5 , .75, 1), na.rm=TRUE)
```
- Para variáveis de texto, pode ser interessante fazer uma **tabela com a contagem** de cada possível categoria de uma variável. Isto é possível por meio da função `table()` e aplicaremos `prop.table(table())` para visualizar em **percentuais**.
```{r}
table(bd_air$Month, useNA="ifany") # mostrando os NA's
prop.table(table(bd_air$Month, useNA="ifany"))
```
- Também podemos incluir mais uma variável em `table()` para verificar alguma relação entre categorias de 2 variáveis:
```{r}
table(bd_air$Month, bd_air$Wind, useNA="ifany")
```


# Manipulação de dados

> “Between 30% to 80% of the data analysis task is spent on cleaning and understanding the data.” (Dasu \& Johnson, 2003)

## Extração de subconjuntos
- <https://www.coursera.org/learn/data-cleaning/lecture/aqd2Y/subsetting-and-sorting>
- Como exemplo, criaremos um _data frame_ com três variáveis, em que, para misturar a ordem dos números, usaremos a função `sample()` num vetor de números e também incluiremos alguns valores ausentes `NA`.
```{r}
set.seed(2022)
x = data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x

x$var2[c(1, 3)] = NA
x
```
- Lembre-se que, para extrair um subconjunto de um data frame, usamos as chaves `[]` indicando vetores de linhas e de colunas (ou também os nomes das colunas).
```{r}
x[, 1] # Todas linhas e 1ª coluna
x[, "var1"] # Todas linhas e 1ª coluna (usando seu nome)
x[1:2, "var2"] # Linhas 1 e 2, e 2ª coluna (usando seu nome)
```
- Note que, podemos usar expressões lógicas (vetor com `TRUE` e `FALSE`) para extrair uma parte do data frame. Por exemplo, queremos obter apenas as observações em que a variável 1 seja menor ou igual a 3 **E** (`&`) que a variável 3 seja estritamente maior do que 11:
```{r}
x$var1 <= 3 & x$var3 > 11

# Extraindo as linhas de x
x[x$var1 <= 3 & x$var3 > 11, ]
```
- Poderíamos também obter apenas as observações em que a variável 1 seja menor ou igual a 3 **OU** (`|`) que a variável 3 seja estritamente maior do que 11:
```{r}
x[x$var1 <= 3 | x$var3 > 11, ]
```
- Também podemos verificar se determinados valores estão contidos em um vetor específico (equivale `==` com mais de um valor)
```{r}
x$var1 %in% c(1, 5) # obs em que var1 é igual a 1 ou 5
x[x$var1 %in% c(1, 5), ]
```

- Note que, ao escrevermos uma expressão lógica para um vetor que contém valores ausentes, gerará um vetor com `TRUE`, `FALSE` e `NA`
```{r}
x$var2 > 8
x[x$var2 > 8, ]
```
- Para contornar este problema, podemos usar a função `which()` que, ao invés de gerar um vetor de `TRUE`/`FALSE`, retorna um vetor com as posições dos elementos que tornam a expressão lógica verdadeira
```{r}
which(x$var2 > 8)
x[which(x$var2 > 8), ]
```
- Outra forma de contornar os valores ausentes é incluir a condição 
de não incluir valores ausentes `!is.na()`:
```{r}
x$var2 > 8 & !is.na(x$var2)
x[x$var2 > 8 & !is.na(x$var2), ]
```


## Ordenação
- Podemos usar a função `sort()` para ordenar um vetor de maneira crescente (padrão) ou decrescente:
```{r}
sort(x$var1) # ordenando de maneira crescente
sort(x$var1, decreasing=TRUE) # ordenando de maneira decrescente
```
- Por padrão, o `sort()` retira os valores ausentes. Para mantê-los e deixá-los no final, precisamos usar o argumento `na.last=TRUE`
```{r}
sort(x$var2) # ordenando e retirando NA
sort(x$var2, na.last=TRUE) # ordenando e mantendo NA no final
```
- Note que não podemos usar a função `sort()` para ordenar um data frame, pois a função retorna valores e, portanto, não retorna suas posições.
```{r}
sort(x$var3)
x[sort(x$var3), ] # Retorna erro, pois não há nº de linhas > 5
```
- Para ordenar data frames, precisamos utilizar a função `order()` que, ao invés de retorar os valores em algum ordem, retorna as suas posições
```{r}
order(x$var3)
x[order(x$var3), ] # Retorna erro, pois não há nº de linhas > 5
```

## Inclusão de novas colunas/variáveis
- Para incluir novas variáveis, podemos usar `$<novo_nome_var>` e atribuir um vetor de mesmo tamanho (mesma quantidade de linhas):
```{r}
set.seed(1234)
x$var4 = rnorm(5)
x
```

- Algumas transformações comuns de variáveis <https://www.coursera.org/learn/data-cleaning/lecture/r6VHJ/creating-new-variables>
```{r}
abs(x$var4) # valor absoluto
sqrt(x$var4) # raiz quadrada
ceiling(x$var4) # valor inteiro acima
floor(x$var4) # valor inteiro abaixo
round(x$var4, digits=1) # arredondamento com 1 dígito
cos(x$var4) # cosseno
sin(x$var4) # seno
log(x$var4) # logaritmo natural
log10(x$var4) # logaritmo base 10
exp(x$var4) # exponencial
```



## Juntando base de dados

### Acrescentando colunas e linhas via `cbind()` e `rbind()`

- Uma maneira de juntar o data frame com um vetor de mesmo tamanho é usando `cbind()`
```{r}
y = rnorm(5)
x = cbind(x, y)
x
```
- Também podemos acrescentar linhas usando `rbind()`, desde que o vetor tenha a quantidade de elementos igual ao número de colunas (ou data frame a ser incluído tenha o mesmo número de colunas)
```{r}
z = rnorm(5)
x = rbind(x, z)
x
```

### Mesclando base de dados com `merge()`
- <https://www.coursera.org/learn/data-cleaning/lecture/pVV6K/merging-data>
- Podemos juntar base de dados a partir de uma variável-chave que aparece em ambas bases.
- Como exemplo, utilizaremos duas bases de dados de respostas a perguntas (`solutions`) e de correções feitas por seus pares (`reviews`).
```{r}
solutions = read.csv("https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv")
head(solutions)

reviews = read.csv("https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv")
head(reviews)
```
- Note que:
    - as primeiras colunas das bases `solutions` e `reviews`` são os identificadores únicos das soluções e dos reviews, respectivamente.
    - na base `reviews` há a coluna _problem_id_ que faz a ligação entre esta base com a coluna _id_ da base `solutions`.
- Usaremos a função `merge()` para juntar ambas bases em uma só, a partir do id da solução.

```yaml
merge(x, y, by = intersect(names(x), names(y)),
      by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
      sort = TRUE, suffixes = c(".x",".y"), ...)

x, y: data frames, or objects to be coerced to one.
by, by.x, by.y: specifications of the columns used for merging. See ‘Details’.
all: logical; all = L is shorthand for all.x = L and all.y = L, where L is either TRUE or FALSE.
all.x: logical; if TRUE, then extra rows will be added to the output, one for each row in x that has no matching row in y. These rows will have NAs in those columns that are usually filled with values from y. The default is FALSE, so that only rows with data from both x and y are included in the output.
all.y: logical; analogous to all.x.
sort: logical. Should the result be sorted on the by columns?
suffixes: a character vector of length 2 specifying the suffixes to be used for making unique the names of columns in the result which are not used for merging (appearing in by etc).
```

```{r, echo=FALSE}
# Define variable containing url
url <- "https://fhnishida.github.io/fearp/econometria1/merge.webp"
```
<center><img src="`r url`"></center>

```{r}
mergedData = merge(reviews, solutions,
                   by.x="solution_id",
                   by.y="id",
                   all=TRUE)
head(mergedData)
```

- Note que, como há colunas de mesmos nomes, e especificamos que a variável chave era somente o id de solução, então as colunas de nomes iguais foram renomeadas com sufixos `.x` e `.y`, correspondendo às 1ª e 2ª bases inseridas na função `merge()`
- Para verificar as colunas com mesmos nomes em duas bases, podemos usar a função `intersect()` em conjunto com a função `names()`:
```{r}
intersect( names(solutions), names(reviews) )
```
- Se não especificássemos nenhuma variável-chave, a função `merge()` utilizaria como variável-chave todas as colunas com nomes iguais em ambas bases de dados 
```{r}
wrong = merge(reviews, solutions,
                   all=TRUE)
head(wrong)
```




# Manipulação via `dplyr` e `tidyr`
- <https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html>
- O pacote `dplyr` facilita a manipulação dos dados por meio de funções simples e computacionalmente eficientes
- As funções pode, ser organizadas em três categorias:
    - Colunas:
        - `select()`: seleciona (ou retira) as colunas do data frame
        - `rename()`: muda os nomes das colunas
        - `mutate()`: cria ou muda os valores nas colunas
    - Linhas:
        - `filter()`: seleciona linhas de acordo com valores das colunas
        - `arrange()`: organiza a ordem das linhas
    - Grupo de linhas:
        - `summarise()`: colapsa um grupo em uma única linha
- Nesta subseção, continuaremos utilizando a base de dados de Star Wars (`starwars`), utilizada na subseção anterior.
- Você irá notar que, ao usar essas funções, o data frame é transformado em um _tibble_ que é um formato mais eficiente para tratar dados tabulares, mas que funciona de forma igual a um data frame.

```{r}
library("dplyr")
detach("package:MASS", unload = TRUE) # pode conflitar com select() deste pacote se estiver ativo

bd_sw = starwars # Dando novo nome para a base starwars
head(bd_sw)
```


## Filtre linhas com `filter()`
- Permite selecionar um subconjunto de linhas de um data frame
```yaml
filter(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: <data-masking> Expressions that return a logical value, and are defined in terms of the variables in .data. If multiple expressions are included, they are combined with the & operator. Only rows for which all conditions evaluate to TRUE are kept.
```
- 
```{r}
bd_sw1 = filter(bd_sw, species == "Human", height >= 100)
bd_sw1

# Equivalente a:
bd_sw[bd_sw$species == "Human" & bd_sw$height >= 100, ]
```

## Organize linhas com `arrange()`
- Reordena as linhas a partir de um conjunto de nomes de coluna
```yaml
arrange(.data, ..., .by_group = FALSE)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
... : <data-masking> Variables, or functions of variables. Use desc() to sort a variable in descending order.
```
- Se for inserido mais de um nome de variável, organiza de acordo com a 1ª variável e, em caso de ter linhas com o mesmo valor na 1ª variável, ordena estas linhas de mesmo valor de acordo com a 2ª variável
- Para usar a ordem decrescente, temos a função `desc()`
```{r}
bd_sw2 = arrange(bd_sw1, height, desc(mass))
bd_sw2
```


## Selecione colunas com `select()`
- Seleciona colunas que são de interesse.
```yaml
select(.data, ...)

... : variables in a data frame
: for selecting a range of consecutive variables.
! for taking the complement of a set of variables.
c() for combining selections.
```
- Coloca-se os nomes das colunas desejadas para selecioná-las.
- Também é possível selecionar um intervalo de variáveis usando `var1:var2`
- Caso queira tirar apenas algumas colunas, basta informar o nome delas precedidas pelo sinal de subtração (`-var`)
```{r}
bd_sw3 = select(bd_sw2, name:eye_color, sex:species)
# equivalente: select(bd_sw2, -birth_year, -c(films:starships))
bd_sw3
```
- Note que o `select()` pode não funcionar corretamente se o pacote `MASS` estiver ativo. Caso esteja, retire a seleção do pacote `MASS` no quadrante inferior/direito em 'Packages' (ou digite `detach("package:MASS", unload = TRUE)`)
- Uma outra forma de fazer a seleção de coluna é combinando com `starts_with()` e `ends_with()`, que resulta na seleção de colunas que se iniciam e terminam com um texto dado
```{r}
head( select(starwars, ends_with("color")) ) # colunas que terminam com color
head( select(starwars, starts_with("s")) ) # colunas que iniciam com a letra "s"
```

## Renomeie colunas com `rename()`
- Renomeia colunas usando `novo_nome = velho_nome`
```yaml
rename(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: For rename(): <tidy-select> Use new_name = old_name to rename selected variables.
```

```{r}
bd_sw4 = rename(bd_sw3,
                haircolor = hair_color,
                skincolor = skin_color, 
                eyecolor = eye_color)
bd_sw4
```


## Modifique/Adicione colunas com `mutate()`
- Modifica uma coluna se ela já existir
- Cria uma coluna se ela não existir
```yaml
mutate(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: <data-masking> Name-value pairs. The name gives the name of the column in the output. The value can be:
 - A vector of length 1, which will be recycled to the correct length.
 - A vector the same length as the current group (or the whole data frame if ungrouped).
 - NULL, to remove the column.
```
```{r}
bd_sw5 = mutate(bd_sw4,
                height = height/100, # transf cm p/ metro
                BMI = mass / height^2,
                dummy = 1 # se não for vetor, tudo fica igual
                )
bd_sw5 = select(bd_sw5, BMI, dummy, everything()) # facilitar
bd_sw5
```

## Operador Pipe `%>%`
- Note que todas as funções do pacote `dyplr` anteriores têm como 1º argumento a base de dados (`.data`), e isto não é por acaso.
- O operador pipe `%>%` joga um data frame (escrito à sua esquerda) no 1º argumento da função seguinte (à sua direita).
```{r}
filter(starwars, species=="Droid") # sem operador pipe
starwars %>% filter(species=="Droid") # com operador pipe
```
- Observe que, ao usar o operador pipe, o 1º argumento com a base de dados não deve ser preenchida (já está sendo aplicada automaticamente via `%>%`).
- Note que, desde a subseção com a função `filter()` até `mutate()` fomos "acumulando" as alterações em novos data frames, ou seja, o último data frame `bd_sw5` é a base original `starwars` que foi alterada por `filter()`, `arrange()`, `select()`, `rename()` e `mutate()`.
```{r}
bd_sw1 = filter(starwars, species == "Human", height >= 100)
bd_sw2 = arrange(bd_sw1, height, desc(mass))
bd_sw3 = select(bd_sw2, name:eye_color, sex:species)
bd_sw4 = rename(bd_sw3,
                haircolor = hair_color,
                skincolor = skin_color, 
                eyecolor = eye_color)
bd_sw5 = mutate(bd_sw4,
                height = height/100,
                BMI = mass / height^2,
                dummy = 1
                )
bd_sw5 = select(bd_sw5, BMI, dummy, everything())
bd_sw5
```
- Usando o operador pipe `%>%` várias vezes, podemos ir pegando o output resultante da aplicação de uma função e jogar como input da função seguinte. Reescreveremos o código acima "em única linha" com `%>%`, chegando ao mesmo data frame de `bd_sw5`
```{r}
bd_sw_pipe = starwars %>% 
    filter(species == "Human", height >= 100) %>%
    arrange(height, desc(mass)) %>%
    select(name:eye_color, sex:species) %>%
    rename(haircolor = hair_color,
           skincolor = skin_color, 
           eyecolor = eye_color) %>%
    mutate(height = height/100,
           BMI = mass / height^2,
           dummy = 1
           ) %>%
    select(BMI, dummy, everything())
bd_sw_pipe

all(bd_sw_pipe == bd_sw5, na.rm=TRUE) # verificando se todos elementos são iguais
```

## Resuma com `summarise()`

- Podemos usar a função `summarise()` para gerar alguma estatística acerca de uma ou mais variáveis:
```{r}
starwars %>% summarise(
    n_obs = n(),
    mean_height = mean(height, na.rm=TRUE),
    mean_mass = mean(mass, na.rm=TRUE)
    )
```
- No caso acima, gerou simplesmente o tamanho da amostra e as médias de altura e de massa considerando a amostra inteira de `starwars` (o que não foi muito útil).


## Agrupe com `group_by()`
- Diferente das outras funções do `dplyr` mostradas até agora, o output do `group_by` não altera conteúdo do data frame, apenas **transforma em uma base de dados agrupada** em categorias de uma dada variável
```{r}
grouped_sw = starwars %>% group_by(sex)
class(grouped_sw)

head(starwars)
head(grouped_sw) # agrupado por sexo
```
- O `group_by()` prepara o data frame para operações que consideram várias linhas. Como exemplo, vamos criar uma coluna com a soma de `mass` de todas observações
```{r}
starwars %>%
    mutate(mean_mass = mean(mass, na.rm=TRUE)) %>% 
    select(mean_mass, sex, everything()) %>%
    head(10)
```
- Note que todos os valores de `mean_mass` são iguais. Agora, agruparemos por `sex` antes de fazer a soma:
```{r}
starwars %>%
    group_by(sex) %>%
    mutate(mean_mass = mean(mass, na.rm=TRUE)) %>% 
    ungroup() %>% # Lembre-se sempre de desagrupar depois!
    select(mean_mass, sex, everything()) %>%
    head(10)
```
- Note que, agora, a coluna `mean_mass` tem valores diferentes de acordo com o sexo da observação.
- Isso é útil em algumas aplicações econômicas em que consideramos variáveis a nível de grupo (e.g. domicílio) a qual uma observação (e.g. morador) pertence.

> **Evite potenciais erros**: Sempre que usar `group_by()`, não se esqueça de desagrupar o data frame via função `ungroup()` após realizar a operações desejadas.

## Resuma em grupos com `group_by()` e `summarise()`
- A função `summarise()` é de fato útil quando combinada com a função `group_by()`, pois conseguimos obter as estatísticas de grupos:
```{r}
summary_sw = starwars %>% group_by(sex) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE),
        mean_mass = mean(mass, na.rm = TRUE)
    )
summary_sw
class(summary_sw) # ao usar summary, deixa de ser agrupada
```
- Note que, ao usar `summarise()`, o data frame resultante não é agrupado e, portanto, não é necessário usar `ungroup()` neste caso.
- Também é possível adicionar mais de uma variável para agrupar:
```{r}
starwars %>% group_by(sex, hair_color) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE),
        mean_mass = mean(mass, na.rm = TRUE)
    )
```
- Para agrupar variáveis **contínuas**, precisamos definir intervalos usando a função `cut()`
```yaml
cut(x, ...)

x: a numeric vector which is to be converted to a factor by cutting.

breaks: either a numeric vector of two or more unique cut points or a single number (greater than or equal to 2) giving the number of intervals into which x is to be cut.
```
```{r}
# breaks com um integer = qtd desejada de grupos
starwars %>% group_by(cut(birth_year, breaks=5)) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE)
    )

# breaks com um vetor = quebras dos intervalos dos grupos
starwars %>% group_by(birth_year=cut(birth_year, 
                          breaks=c(0, 40, 90, 200, 900))) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE)
    )
```
- Note que inserimos `birth_year=cut(birth_year, ...)` para que o nome da coluna ficasse `birth_year`, caso contrário a coluna ficaria com o nome `cut(birth_year, ...)`.

## Reestruture dados em _wide_ ou _long_
- <https://tidyr.tidyverse.org/articles/pivot.html>
- As bases de dados costumam ser disponibilizadas no formato _wide_, em que cada linha corresponde a uma observação/indivíduo. Já o formato _long_, refere-se ao formato em que cada observação/indivíduo aparece em mais de uma linha:
    - em que cada indivíduo é observado mais de uma vez no tempo (dados em painel ou  séries temporais), ou
    - em que cada indivíduo toma decisão considerando várias possíveis escolhas (logit multinomial)
- Logo, recorrentemente, precisamos transformar bases do formato _wide_ no formato _long_, ou vice-versa.
- Para fazer essas transformações usaremos o pacote `tidyr` e suas funções `pivot_longer()`, `pivot_wider` e `separate()`
```{r}
library(tidyr)
```
- `pivot_longer()` aumenta o nº de linhas e diminui o de colunas.
```yaml
pivot_longer(
  data,
  cols,
  names_to = "name",
  names_prefix = NULL,
  names_sep = NULL,
  names_pattern = NULL,
  names_ptypes = NULL,
  names_transform = NULL,
  names_repair = "check_unique",
  values_to = "value",
  values_drop_na = FALSE,
  values_ptypes = NULL,
  values_transform = NULL,
  ...
)
```
- `pivot_wider()` aumenta o nº de colunas e diminui o de linhas.
```yaml
pivot_wider(
  data,
  id_cols = NULL,
  id_expand = FALSE,
  names_from = name,
  names_prefix = "",
  names_sep = "_",
  names_glue = NULL,
  names_sort = FALSE,
  names_vary = "fastest",
  names_expand = FALSE,
  names_repair = "check_unique",
  values_from = value,
  values_fill = NULL,
  values_fn = NULL,
  unused_fn = NULL,
  ...
)
```
- `separate()` divide uma coluna em duas a partir de um caracter "separador".
```yaml
separate(
  data,
  col,
  into,
  sep = "[^[:alnum:]]+",
  remove = TRUE,
  convert = FALSE,
  extra = "warn",
  fill = "warn",
  ...
)
```

### Exemplo 1: _wide_ $\rightarrow$ _long_
- A base de dados abaixo possui informações de 5 condados com suas repectivas áreas territoriais, proporções de adultos com ensino superior e nº de vagas de emprego em 4 anos distintos:
```{r}
bd_counties = data.frame(
    county = c("Autauga", "Baldwin", "Barbour", "Bibb", "Blount"),
    area = c(599, 1578, 891, 625, 639),
    college_1970 = c(.064, .065, .073, .042, .027),
    college_1980 = c(.121, .121, .092, .049, .053),
    college_1990 = c(.145, .168, .118, .047, .070),
    college_2000 = c(.180, .231, .109, .071, .096),
    jobs_1970 = c(6853, 19749, 9448, 3965, 7587),
    jobs_1980 = c(11278, 27861, 9755, 4276, 9490),
    jobs_1990 = c(11471, 40809, 12163, 5564, 11811),
    jobs_2000 = c(16289, 70247, 15197, 6098, 16503)
)
bd_counties
```
- Queremos estruturar a base de dados de modo que, para cada condado, tenhamos 4 linhas (cada uma corresponde a um dos anos: 1970, 1980, 1990 ou 2020). Portanto, teremos 5 colunas: _county_, _year_, _area_, _college_ e _jobs_. Começamos transformando as colunas cujos nomes iniciam com `college_` e com `jobs_` em linhas via `pivot_longer()`:
```{r}
bd_counties2 = bd_counties %>%
    pivot_longer(
        cols = c( starts_with("college_"), starts_with("jobs_") ),
        names_to = "var_year", # nome da coluna que vão os nomes das colunas antigas
        values_to = "value" # nome da coluna com os valores das colunas transformadas
    )
head(bd_counties2, 10)
```
- Note que, para cada condado, há duas linhas para cada ano, já que há 2 que variam no tempo (_college_ e _jobs_). Precisamos tirar essa duplicidade de anos. Começamos usando a função `separate()` para separar a variável `var_year` em duas colunas (que chamaremos de `var` e `year`):
```{r}
bd_counties3 = bd_counties2 %>%
    separate(
        col = "var_year",
        into = c("var", "year"), # nomes das colunas separadas
        sep = "_" # caracter que separa as valores na coluna antiga "var_year" 
    )
head(bd_counties3, 10)
```
- Agora, transformaremos a coluna `var` em 2 colunas (`college`, `jobs`), usando a função `pivot_wider()`:
```{r}
bd_counties4 = bd_counties3 %>%
    pivot_wider(
        names_from = "var",
        values_from = "value"
    )
bd_counties4 %>% select(county, year, everything()) %>% head(10)
```
- Observe que, se só houvesse uma variável variante no tempo, não seria necessário usar o `pivot_wider()`, pois haveria 1 linha para cada ano para cada condado.


### Exemplo 2: _long_ $\rightarrow$ _wide_
- Usaremos agora a base de dados `TravelMode` do pacote `AER` que possui 840 observações em que 210 indivíduos escolhem um modo de viagem entre 4 opções: carro, aéreo, trem ou ônibus.
- Note que cada um dos 210 indivíduos aparecem em 4 linhas, em que cada um corresponde a um dos modos de viagem.
- Há variáveis específicas de
    - indivíduo (_individual_, _income_ e _size_) que são repetidas nas 4 linhas em que aparece, e
    - escolha (_choice_, _wait_, _vcost_, _travel_ e _gcost_) que variam de acordo com os modos de viagem.
```{r}
data("TravelMode", package = "AER")
head(TravelMode, 8)
```
- Agora, vamos fazer com que haja apenas uma linha por indivíduo, retirando a coluna _mode_ e gerando diversas colunas para cada possível modo de viagem.
```{r}
TravelMode2 = TravelMode %>% 
    pivot_wider(
        names_from = "mode",
        values_from = c("choice":"gcost") # variáveis específicas do modo
    )
head(TravelMode2)
```
- Note que, para cada modo de viagem, foram criadas 5 colunas, que correspondem às 5 variáveis específicas de escolha. No total, foram retiradas 6 colunas (_mode_ + 5 variáveis específicas de escolha) e foram criadas 20 (4 modos $\times$ 5 variáveis específicas de escolha) colunas.
- Em algumas aplicações econométricas (e.g. logit multinomial) é necessário que haja apenas uma coluna indicando a escolha da opção. Então, criaremos a coluna `choice` indicando qual opção escolheu (_air_, _train_, _bus_ ou _car_) e vamos retirar as 4 colunas que começam com "choice_":
```{r}
TravelMode3 = TravelMode2 %>% 
    mutate(
        choice = case_when(
            choice_air == "yes" ~ "air",
            choice_train == "yes" ~ "train",
            choice_bus == "yes" ~ "bus",
            choice_car == "yes" ~ "car"
        )
    ) %>% select(individual, choice, 
                 starts_with("wait_"), starts_with("vcost_"),
                 starts_with("travel_"), starts_with("gcost_")
                 )

TravelMode3 %>% head(10)
```


## Junte bases de dados com funções _join_
- Vimos anteriormente que podemos usar o `cbind()` juntar um data frame com outro data frame (ou vetor), caso tenham o mesmo número de linhas
- Para juntar linhas (considerando que as colunas possuem as mesmas classes de variáveis), podemos usar o `rbind`
- O pacote `dplyr` fornece outras maneiras de juntar base de dados a partir de uma família de funções _join_, que pode ser resumida na seguinte figura:

```{r, echo=FALSE}
# Define variable containing url
url <- "https://fhnishida.github.io/fearp/econometria1/dplyr-data-join-functions.png"
```
<center><img src="`r url`"></center>

- Todas as funções possuem a mesma sintaxe:
    - `x`: base 1
    - `y`: base 2
    - `by`: vetor de variáveis-chave
    - `suffix`: vetor de 2 sufixos para incluir em colunas de mesmos nomes
- Como exemplo, usaremos subconjuntos da base de dados `starwars`:
```{r}
bd1 = starwars[1:6, c(1, 3, 11)]
bd2 = starwars[c(2, 4, 7:10), c(1:2, 6)]
bd1
bd2
```
- Note que há 12 personagens únicos em ambas bases, mas apenas "C-3PO" e "Darth Vader" são observações comuns.
- `inner_join()`: mantém apenas ID's presentes simultaneamente em ambas bases
```{r}
inner_join(bd1, bd2, by="name")
```

- `full_join()`: mantém todas ID's, mesmo que estejam em apenas em um das bases
```{r}
full_join(bd1, bd2, by="name")
```
- `left_join()`: mantém apenas ID's presentes na base 1 (informada como `x`)
```{r}
left_join(bd1, bd2, by="name")
```
- `right_join()`: mantém apenas ID's presentes na base 2 (informada como `y`)
```{r}
right_join(bd1, bd2, by="name")
```

- Note que podemos incluir mais de uma variável-chave para correspondência entre ID's de ambas bases. Primeiro, vamos construir as bases como paineis
```{r}
bd1 = starwars[1:5, c(1, 3)]
bd1 = rbind(bd1, bd1) %>%
    mutate(year = c(rep(2021, 5), rep(2022, 5)),
           # Se não for ano 2021, multiplica por um número aleatório ~ N(1, 0.025)
           mass = ifelse(year == 2021, mass, mass*rnorm(10, 1, 0.025))) %>%
    select(name, year, mass) %>%
    arrange(name, year)
bd1

bd2 = starwars[c(2, 4, 7:9), 1:2]
bd2 = rbind(bd2, bd2) %>%
    mutate(year = c(rep(2021, 5), rep(2022, 5)),
           # Se não for ano 2021, altura cresce 2%
           height = ifelse(year == 2021, height, height*1.02)) %>%
    select(name, year, height) %>%
    arrange(name, year)
bd2
```
- Note agora que, para cada personagem, temos 2 linhas que correspondem aos dois anos (2021 e 2022). Faremos um `full_join()` considerando como variáveis-chave ambos `name` e `year`.
```{r}
# Juntando as bases
full_join(bd1, bd2, by=c("name", "year"))
```
- Atente-se também aos nomes das variáveis, pois ao juntar bases com variáveis de mesmos nomes (que não são usadas como chave), a função acaba incluindo ambas variáveis renomeadas, por padrão, com sufixos `.x` e `.y` (sufixos podem ser alterados pelo argumento `suffix`)
```{r}
bd2 = bd2 %>% mutate(mass = rnorm(10)) # Criando uma variável mass

full_join(bd1, bd2, by=c("name", "year"))
```


# Gráficos

## Gráficos via funções nativas do R
- A forma mais rápida de fazer a visualização dos gráficos

## Gráficos via pacote `ggplot2`
- <https://r-graph-gallery.com>
