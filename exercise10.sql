SELECT * FROM users WHERE country_code LIKE '__';

/* O problema exigia que eu os usuários que possuíssem o country_code com apenas 2 algarismos.
Para realizar isso, utilizei o SELECT * from users, para 
trabalhar com as informações gerais dos users, e usei o WHERE country_code LIKE, para inserir
uma restrição que procurasse por um termo específico, e então inseri dois underscores ('__'), 
visto que esses caracteres podem representar uma única e qualquer letra.
Resolvi dessa maneira para colocar em prática o uso do WHERE ... LIKE, que eu aprendi em uma vídeo-aula,
junto com a funcionalidade dos underscores.
*/