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

SELECT DISTINCT
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END AS Estado
FROM ideb2017

-- Mas podemos nomear mais colunas se quisermos, só é preciso lembrar de separá-las pela vírgula:

SELECT DISTINCT
	CASE
		WHEN uf = 'RO' THEN 'Rondônia'
		ELSE 'não é Rondônia'
	END AS Estado,
	nome_munic AS Município
FROM ideb2017




/*
Os comandos acima servem para estabelecer condições de:
- seleção de colunas (as variáveis da tabela);
- tratamento dos nomes das colunas ou valores contidos nelas.
*/

/* ### WHERE ### 

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
WHERE SG_UF_NASCIMENTO = 'AC'

/* IMPORTANTE: o WHERE sempre vai após o FROM, que sempre vai após o SELECT! 
Pense nos três como orações diferentes numa mesma frase.
Quando você passa de uma oração para outra, nunca pode separá-las por vírgula.
*/

-- Notou que acrescentamos um elemento novo, o sinal de "igual"? Ele é um dos chamados "operadores lógicos", que usamos para criar nossos filtros:

/*
LISTA DE OPERADORES LÓGICOS:
- De comparação:
	= (igual a)
	<> (diferente de)
	!= (diferente de)
	< (menor que)
	> (maior que)
	<= (menor ou igual a)
	>= (maior ou igual a)
- Lógicos:
	AND (uma condição E outra condição)
	OR (uma OU outra condição)
- Intervalo de valores:
	BETWEEN (valores ENTRE x E y)
- Pertencimento a conjuntos:
	IN (contido em tal conjunto)
	NOT IN (não contido em tal conjunto)
- Buscar em parte do texto:
	LIKE (texto inclui tal trecho)
	NOT LIKE (texto não inclui tal trecho)
- Nulabilidade:
	IS NULL (célula daquela coluna, naquela linha, não foi preenchido)
	IS NOT NULL (exclui as linhas com células sem preenchimento em uma coluna específica)
	*/
	
-- Frase 6: "Selecionar as mesmas colunas do Acre que a frase 5, mas filtrando só pelos candidatos homens com mais de 50 anos."

-- Tradução para o SQL:

SELECT
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC' AND
	TP_SEXO = 'M' AND
	NU_IDADE > 50
	
-- Frase 7: "Selecionar as mesmas colunas do Acre que a frase 6, mas agora filtrando só pelas mulheres com idade entre 18 e 24 anos."

SELECT
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC' AND
	TP_SEXO = 'F' AND
	(NU_IDADE BETWEEN 18 AND 24)
	
/* Notou que usamos parênteses no exemplo acima?
O motivo é para evitar que o "AND" do intervalo selecionado pelo comando BETWEEN seja interpretado como uma mudança de comando.
Para que o programa consiga entender exatamente o que você quer, é preciso prestar atenção nos detalhes.
Veja em mais um exemplo abaixo:
*/

-- Frase 8: "Selecionar apenas candidatas mulheres no Acre que (tiveram nota de redação entre 800 e 1000) OU (tiveram nota 0 na redação)."

-- Tradução para o SQL:

SELECT
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO,
	NU_NOTA_REDACAO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC' AND
	TP_SEXO = 'F' AND
	((NU_NOTA_REDACAO BETWEEN 800 AND 1000) OR
	NU_NOTA_REDACAO = 0)
	
-- Frase 9: "Selecionar apenas candidatas mulheres no Acre que (tiveram nota 1000 na redação) OU (tiveram nota 0 na redação)."

-- Tradução para o SQL:
	
SELECT
	SG_UF_NASCIMENTO,
	TP_SEXO,
	NU_NOTA_REDACAO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC' AND
	TP_SEXO = 'F' AND
	(NU_NOTA_REDACAO = 1000 OR
	NU_NOTA_REDACAO = 0)
	
/* Notou que alguns valores são colocados entre aspas e ficam vermelhos, enquanto outros vão sem aspas e ficam na cor preta?
O motivo é que são TIPOS DE DADOS diferentes: uns são TEXT (texto), outros são INTEGER (números inteiros).
O texto sempre vai entre aspas simples. Os números não precisam de aspas.
Mas se você usar texto sem aspas, o código dá errado, porque o programa espera que valores foram de aspas tenham apenas números, não letras.
Já qualquer dígito pode ser lido como texto.
*/

-- Teste na query abaixo:

SELECT
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = AC AND
	TP_SEXO = F AND
	(NU_IDADE BETWEEN 18 AND 24)

/*ALGUNS TIPOS DE DADOS:
- TEXT: texto (aceita qualquer dígito)
- CHAR(n): um campo de texto, mas tem definido um número fixo de caracterers (por exemplo: campo UF, com n = 2)
- VARCHAR(n): um campo de texto com tamanho variável e que aceita até um número máximo de caracteres (por exemplo: campo para nome completo)
- INTEGER: número inteiro
- DECIMAL: número com casas decimais
- REAL: também representa valores numéricos, mas com valores aproximados
- BOOLEAN: traz os valores TRUE (verdadeiro) ou FALSE (falso)
- DATE, TIMESTAMP: dados referentes a data e/ou hora
*/

-- DICA: O DB-Broswer costuma ler o tipo de dado de cada coluna, mas é possível alterá-lo manualmente.

/* ### GROUP BY ###*/

/*O comando GROUP BY serve para que você consiga agrupar os resultados de uma certa coluna para poder observar melhor seus dados.
Para entender a sintaxe dele, é preciso enxergar as variávies que você lista dentro do comando SELECT pela ordem em que estão dispostas (posição 1, 2 etc.).*/

/*FUNÇÕES DE AGRUPAMENTO: são usadas para contagem ou cálculos que consolidam todas as suas linhas em resumos.
- COUNT: é usada para somar a quantidade de linhas em uma tabela ou para contar a soma de valores distintos de uma mesma coluna
- SUM: soma de valores em uma coluna numérica
- MAX: mostra o valor máximo existente em uma coluna numérica
- MIN: mostra o valor mínimo existente em uma coluna numérica
- AVG: vem de "average" ("média", em inglês) e calcula a média de todos os valores em uma coluna numérica
*/

-- Frase 10: "Contar quantas linhas tem a base enem2019."

-- Tradução para o SQL:

SELECT count(*) FROM enem2019

-- Frase 11: "Contar quantos candidatos da base enem2019 são homens e quantos são mulheres."

-- Tradução para o SQL:

SELECT
	TP_SEXO, 
	count(*) AS QTDE_PORSEXO
FROM enem2019
GROUP BY TP_SEXO

-- Frase 12: "Selecionar apenas candidatos e candidatas com nota mil na redação, e contar quantos são homens e quantos são mulheres."

-- Tradução para o SQL:

SELECT TP_SEXO, 
	count(*) AS QTDE_NOTAMIL
FROM enem2019
WHERE NU_NOTA_REDACAO = 1000
GROUP BY TP_SEXO

/* ### ORDER BY ###*/

/*O comando ORDER BY ordena seus resultados a partir dos valores de uma das colunas.
A ordem crescente (ASC) é a padrão. Mas é possível alterá-la com uma função ao final do comando (DESC).*/

-- Frase 13: "Selecionar quem fez o Enem no Acre por idade e sexo e ordená-los da maior pra menor nota na redação."

-- Tradução para o SQL:

SELECT 
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO,
	NU_NOTA_REDACAO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC'
ORDER BY
	NU_NOTA_REDACAO DESC

-- Frase 14: "Selecionar quem fez o Enem no Acre por idade e sexo e ordená-los da maior pra menor idade."

-- Tradução para o SQL:

SELECT 
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO,
	NU_NOTA_REDACAO
FROM enem2019
WHERE 
	SG_UF_NASCIMENTO = 'AC'
ORDER BY
	NU_IDADE DESC

-- Frase 15: "Selecionar quem tirou nota mil na redação por UF e ordenar pela ordem alfabética do estado de trás para frente."

-- Tradução para o SQL:

SELECT 
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO,
	NU_NOTA_REDACAO
FROM enem2019
WHERE NU_NOTA_REDACAO = 1000
ORDER BY SG_UF_NASCIMENTO

-- Frase 16: "Contar quantas notas mil cada UF teve e ordenar pela UF com o maior número de notas mil."

-- Tradução para o SQL:

SELECT 
	SG_UF_NASCIMENTO,
	NU_IDADE,
	TP_SEXO,
	COUNT(*) NU_NOTA_REDACAO
FROM enem2019
WHERE NU_NOTA_REDACAO = 1000
GROUP BY SG_UF_NASCIMENTO
ORDER BY NU_NOTA_REDACAO DESC

-- Por fim, aplicamos o "Alias" para deixar a tabela ainda mais legível.

SELECT 
	SG_UF_NASCIMENTO AS Estado,
	NU_IDADE AS Idade,
	TP_SEXO AS Sexo,
	COUNT(*) AS Notas_mil
FROM enem2019
WHERE NU_NOTA_REDACAO = 1000
GROUP BY 1
ORDER BY 4 DESC