SELECT * FROM users WHERE country_code IN ('MX','BR','AR');

/* O problema pede para eu listar as informações dos usuários do México, Brasil e Argentina. 
Para isso, usei o SELECT * para pegar todos os dados, e o WHERE para colocar as restrições, 
com uso do IN para colocar os três parâmetros sem necessidade de escrever country_code três vezes, com o OR.
Escolhi essa maneira de resolver pois é a mais simples e compacta.
*/