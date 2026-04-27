SELECT * FROM transactions WHERE note LIKE '%aluguel%';

/* O problema exigia que eu entregasse as transações que possuíssem o termo 'aluguel' em
qualquer parte do note. Para realizar isso, utilizei o SELECT * from transactions, para 
trabalhar com as informações gerais das transações, e usei o WHERE note LIKE, para inserir
uma restrição que procurasse por um termo específico, e então inseri o termo '%aluguel%', 
com símbolos de porcentagem no início e no final, visto que a palavra 'aluguel' poderia ser
encontrada em qualquer posição na frase.
Resolvi dessa maneira para colocar em prática o uso do WHERE ... LIKE, que eu aprendi em uma vídeo-aula,
junto com o sentido das porcentagens.
*/