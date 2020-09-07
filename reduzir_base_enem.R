
# PRA QUE SERVE ESSE CÓDIGO?
# Nesse exercício, ele serve para criar uma versão reduzida dos microdados do Enem 2019.
# A base na íntegra tem mais de 5 milhões de linhas, mas só queremos uma parte delas:
# Nós queremos apenas quem se inscreveu no Enem, fez todas as provas e estava no terceiro ano do ensino médio.
# Esse universo representa pouco mais de 1 milhão das mais de 5 milhões de linhas da planilha.
# Com esse filtro, nós vamos reduzir o arquivo de 3Gb para menos de 1Gb, e usá-lo com mais facilidade.

# COMO RODAR ESSE CÓDIGO?
# - Selecionar com o mouse as linhas necessárias em cada trecho
# - Clicar em "CTRL+ENTER"
# Esperar até o programa terminar de rodar (alguns computadores levam mais tempo que outros)


# PASSO 1: Instalar os pacotes necessários (selecione as DUAS linhas abaixo e clique em CTRL+ENTER)

install.packages("data.table")
install.packages("tidyverse")


# PASSO 2: Carregar os pacotes recém instalados (selecione as DUAS linhas abaixo e clique em CTRL+ENTER)

library(data.table)
library(tidyverse)


# PASSO 3: Rodar o código que abrir só as linhas da tabela que queremos 
# (selecione as SETE linhas abaixo e clique em CTRL+ENTER)
# AGUARDE!!! Dependendo do seu computador, pode demorar poucos ou muitos minutos

enem2019_comfiltro <- 'MICRODADOS_ENEM_2019.csv' %>% 
  fread() %>% 
  filter(TP_PRESENCA_CN == 1,
         TP_PRESENCA_CH == 1,
         TP_PRESENCA_LC == 1,
         TP_PRESENCA_MT == 1,
         TP_ST_CONCLUSAO == 2)


# PASSO 4: Veja como na janela "Environment" um novo objeto foi criado, chamado "enem2019_comfiltro".


# PASSO 5: Grave esse novo objeto em um arquivo .CSV
# selecione a linha abaixo e clique em CTRL+ENTER
# AGUARDE NOVAMENTE!!! A planilha 

write.csv(com_filtro, "enem2019_comfiltro.csv")


# PASSO 6: Abra a pasta onde você salvou o projeto e veja se a planilha "enem2019_comfiltro.csv" está lá.
# Ela deve ter por volta de 900Mb.

# PRONTO! MISSÃO CUMPRIDA! :)
# PS: Esse código serve para reduzir outras bases grandes, o que vai mudar é o nome do arquivo e os filtros.