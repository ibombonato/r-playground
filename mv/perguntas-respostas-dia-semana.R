getwd()
setwd("C:\\Users\\icaro.MINHAVIDA\\Source\\Repos\\r-playground")
dir.create("mv")
setwd("mv")

fileRespondidas <- "C:\\Users\\icaro.MINHAVIDA\\Dropbox\\R_work\\MV\\data\\respondidas.csv"

dfOriginal <- read.csv2(fileRespondidas, stringsAsFactors = FALSE)
head(dfOriginal)

install.packages("dplyr")
install.packages("lubridate")
require(lubridate)
require(dplyr)
df <- mutate(dfOriginal, 
             pergunta = as.Date(Data.Pergunta, "%Y-%m-%d"), 
             resposta = as.Date(Data.Resposta, "%Y-%m-%d"),
             weekdayPergunta = wday(pergunta, label = TRUE),
             weekdayResposta = wday(resposta, label = TRUE)
    ) %>%
    select(pergunta:weekdayResposta)
head(df)
sum(is.na(df))
df <- 

str(df)

str(df)
install.packages("ggplot2")
install.packages("gridExtra")
require(ggplot2)

group_by_weekday_resposta <- df %>% mutate(tipo = "resposta", diaSemana = weekdayResposta) %>% select(tipo, diaSemana) %>% group_by(diaSemana) 
group_by_weekday_pergunta <- df %>% mutate(tipo = "pergunta", diaSemana = weekdayPergunta) %>% select(tipo, diaSemana) %>% group_by(diaSemana) 

head(group_by_weekday_resposta)
newdf <- rbind(group_by_weekday_resposta, group_by_weekday_pergunta)

group_by_weekday <- newdf %>% group_by(tipo, diaSemana) 
head(group_by_weekday)

ggplot(group_by_weekday, aes(x = diaSemana)) + 
    geom_bar(aes( fill = tipo), position = "dodge")

head(group_by_weekday_resposta)
head(group_by_weekday_pergunta)
gRespostas <- ggplot() + 
    geom_bar(data = group_by_weekday_resposta, aes(x = diaSemana, fill = diaSemana))
    
gRespostas

gPerguntas <- ggplot() +     
    geom_bar(data = group_by_weekday_pergunta, aes(x = weekdayPergunta, fill = weekdayPergunta))

require(gridExtra)
grid.arrange(gRespostas, gPerguntas)


# Quanto maior a quantidade de medicos em uma especialidade, maior o numero de respostas?
