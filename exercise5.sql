SELECT * FROM users WHERE country_code IN ('US', 'CA');

/* O problema pede para eu listar as informações dos usuários dos EUA e Canadá. 
Para isso, usei o SELECT * para pegar todos os dados, e o WHERE para colocar as restrições, 
com uso do IN para colocar os dois parâmetros sem necessidade de escrever country_code duas vezes, com o OR.
Escolhi essa maneira de resolver pois é a mais simples e compacta.
*/