SELECT * FROM users WHERE name LIKE 'A%';

/* O problema pede para eu listar as informações dos users que iniciam com a letra A. 
Para isso, usei o SELECT * FROM users (para pegar todas as informações dos users) 
e coloquei um WHERE para inserir a restrição LIKE, a qual determina um filtro de informações.
Utilizei aspas para iniciar a string, e coloquei o A na primeira posição, visto que queremos
os users cujos nomes iniciam com a letra A, e inseri também um sinal de porcentagem, que
significa que pode ter qualquer letra e comprimento de letra a partir daquele ponto na palavra.
Escolhi essa maneira de resolver pois é a mais simples e compacta.
*/