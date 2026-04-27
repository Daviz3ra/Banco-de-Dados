SELECT * FROM transactions WHERE was_successful=TRUE AND amount>50;

/* O problema pede para eu listar as informações das transações sucedidas, cujo valor seja maior que 50. 
Para isso, usei o SELECT * para pegar todos os dados, e o WHERE para colocar as restrições, 
com uso do AND para unificar os argumentos.
Escolhi essa maneira de resolver pois é a mais simples e compacta.
*/