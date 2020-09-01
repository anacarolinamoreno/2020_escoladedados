-- SELECT FROM WHERE: aprendendo o básico de SQL com a base do Enem 2019

-- É possível escrever comentários entre as linhas de código.

-- Sequência de DOIS HÍFENS: para escrever um comentário de uma linha.

/*
 BARRA+ASTERISCO Serve para escrever
 um comentário de várias linhas.
 Mas para isso é preciso "fechar" o comando.
 Ao final, use a sequência ASTERISCO+BARRA.
*/




/* ### SELECT ### */

/*
Uma das funções do SQL é a consulta a uma base de dados. 
Em geral, é essa a função mais útil para jornalistas.
O comando SELECT é o que dá início à sua consulta.
Para entender o código, pense que você está escrevendo uma frase em uma nova língua.
Uma das tarefas é aprender a ordem em que os elementos da frase devem ser usados, como verbos, substantivos e até a vírgula.
*/

-- Frase 1: "Selecionar tudo da tabela ideb2017"

-- Tradução para o SQL:

SELECT * FROM ideb2017

/* 
SELECT: Comando para selecionar alguma coisa de algum lugar.
O asterisco * é "a coisa". No caso, ele seleciona todas as colunas (ou variáveis) da sua tabela.
FROM: É o comando que vai indicar o lugar de onde você quer selecionar o seu dado. Nesse caso, é a nossa tabela.
*/

-- Frase 2: "Selecionar só as colunas da UF de residência e da cor/raça dos candidatos da tabela ideb2017"

-- Nesse caso, é preciso saber o nome delas, e listá-las depois do comando, separadas por vírgula.

-- Por isso é importante deixar o dicionário de variáveis à mão!

-- Tradução para o SQL:

SELECT nome_munic, uf FROM ideb2017

-- Note que a ordem da sua frase influencia a ordem das colunas na sua tabela nova.

-- Note no exemplo abaixo como o ENTER e a BARRA DE ESPAÇO não afetam o código (você só precisa selecionar todas as linhas antes de executar a consulta).

SELECT nome_munic ,
 uf     FROM 
 ideb2017
 
 /*
Note que, se você digitou tudo direitinho, cada elemento aparece com uma cor diferente:
AZUL: comandos
ROXO: variáveis
VERDE: tabelas
VERMELHO: valores
*/ 
 
 /* ### SELECT DISTINCT ### */

-- O comando SELECT DISTINCT serve para selecionar apenas os valores únicos de uma coluna, sem todas as linhas repetidas.

-- Frase 3: "Selecionar só os valores únicos que aparecem na coluna do estado da tabela ideb2017"

-- Tradução para o SQL:

SELECT DISTINCT uf FROM ideb2017

-- Se selecionarmos uma segunda coluna, o número de linhas será o número de valores possíveis da coluna com mais valores únicos.

-- IMPORTANTE: sempre separar as colunas selecionadas entre vírgulas:

SELECT DISTINCT uf, nome_munic FROM ideb2017


 /* ### CASE ... WHEN ... THEN ... ELSE ... END ### */

/* 
Como os microdados costumam ter valores em códigos (por exemplo, 0 para "Sim" e 1 para "Não"),
o comando "CASE-WHEN" serve para substituir os valores codificados por termos mais fáceis de analisar.
*/

/* 
Frase 4: "Selecionar os valores únicos da coluna estado na tabela ideb2017, mas, 
CASO o valor seja RO, ENTÃO substitua-o por 'Rondônia';
NOS OUTROS CASOS, substitua os valores por 'não é Rondônia';
e É SÓ ISSO."
*/

SELECT  
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END 
FROM ideb2017

-- O END serve para indicar o fim da minha lista de condições.

-- Se eu quiser só os valores únicos, é só adicionar o "DISTINCT" (sempre imediatamente após o "SELECT" e sempre sem vírgula):

SELECT  DISTINCT
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END 
FROM ideb2017

-- Note que o nome da coluna não é mais "uf". Mas existe um comando simples pra renomear essa e qualquer outra coluna:

 /* ### AS (o "alias") ### */
 
/*
"Alias" em inglês é um termo que indica uma forma mais usual de se referir à mesma pessoa.
Assim como o "CASE-WHEN", ele serve como limpeza da base, para facilitar a análise.
No SQL, o comando a ser usado é o AS.
Ele vai no fim de uma coluna na sua lista de seleções.
No nosso caso, a única coluna selecionada termina no END, portanto colocamos o AS depois disso:
*/

SELECT  DISTINCT
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END AS Estado,
FROM ideb2017

-- Mas podemos nomear mais colunas se quisermos, só é preciso lembrar de separá-las pela vírgula:

SELECT  DISTINCT
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END AS Estado,
	nome_munic AS Município
FROM ideb2017


/* ### WHERE ### */

/*
Os comandos acima servem para estabelecer condições de:
- seleção de colunas (as variáveis da tabela);
- tratamento dos nomes das colunas ou valores contidos nelas.

A seguir, veremos como funciona o WHERE, um comando importante para FILTRAR de quais linhas estamos falando.
Para isso, vamos agora mexer um pouco na tabela do enem2019.
*/ 

-- Frase 5: "Selecionar as colunas de estado, idade e sexo, mas apenas os dados de candidatos e candidatas do estado do Ceará na tabela enem2019."

-- Tradução para o SQL:

SELECT
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO
FROM enem2019
WHERE SG_UF_NASCIMENTO = 'RJ'
