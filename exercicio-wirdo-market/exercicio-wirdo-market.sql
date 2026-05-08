CREATE TABLE IF NOT EXISTS 'products' (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  price REAL NOT NULL,
  quantity INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS 'clients' (
id INTEGER PRIMARY KEY AUTOINCREMENT, 
name TEXT NOT NULL, 
email TEXT UNIQUE NOT NULL, 
date_of_registration DATE DEFAULT CURRENT_DATE
)

CREATE TABLE IF NOT EXISTS 'orders' (
id INTEGER PRIMARY KEY AUTOINCREMENT, 
date_hour DEFAULT CURRENT_TIMESTAMP, 
client_id INTEGER NOT NULL, 
status TEXT NOT NULL CHECK(status IN ('pendente', 'pago', 'enviado', 'entregue', 'cancelado')),
last_modified_by TEXT NOT NULL,
last_modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (client_id) REFERENCES clients(id)
)

CREATE TABLE IF NOT EXISTS 'transactions' (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date_hour TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount NUMERIC NOT NULL,
  reason TEXT NOT NULL,
  product_id INTEGER NOT NULL,
  order_id INTEGER NOT NULL, --! LEMBRAR DE CRIAR A TABLE NOVAMENTE AGORA QUE COLOQUEI O "NOT NULL"
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
)

CREATE TABLE IF NOT EXISTS 'order_items'(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
)

CREATE TABLE IF NOT EXISTS 'order_events'(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date_hour TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  order_id INTEGER NOT NULL,
  old_value TEXT NOT NULL,
  new_value TEXT NOT NULL,
  modified_by TEXT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id)
)

--! Inserindo produtos:
INSERT INTO products (name, description, price, quantity)
VALUES ('Monitor 24', 'Monitor LED 24 polegadas Full HD', 850.00, 20);
INSERT INTO products (name, description, price, quantity)
VALUES ('Teclado Mecanico', 'Teclado RGB switch blue', 250.00, 35);
INSERT INTO products (name, description, price, quantity)
VALUES ('Mouse Gamer', 'Mouse com 12000 DPI e cabo trancado', 150.00, 50);
INSERT INTO products (name, description, price, quantity)
VALUES ('Cadeira Office', 'Cadeira ergonômica com ajuste de altura', 550.00, 4);
INSERT INTO products (name, description, price, quantity)
VALUES ('Headset Wireless', 'Fone de ouvido com cancelamento de ruído', 320.00, 30);
INSERT INTO products (name, description, price, quantity)
VALUES ('Webcam Full HD', 'Webcam para streaming 1080p', 200.00, 5);
INSERT INTO products (name, description, price, quantity)
VALUES ('Mousepad Extra Grande', 'Mousepad de tecido 90x40cm', 60.00, 100);

--! Inserindo clientes:
INSERT INTO clients (name, email) VALUES ('Ana Silva', 'ana.silva@email.com');
INSERT INTO clients (name, email) VALUES ('Bruno Oliveira', 'bruno.obj@email.com');
INSERT INTO clients (name, email) VALUES ('Carla Souza', 'carla.tech@email.com');
INSERT INTO clients (name, email) VALUES ('Diego Santos', 'diego.s@email.com');
INSERT INTO clients (name, email) VALUES ('Fernanda Lima', 'fer.lima@email.com');

--! Entradas (Compra de Fornecedor)
INSERT INTO transactions (product_id, amount, reason) VALUES (1, 20, 'compra_fornecedor'); -- Monitor
INSERT INTO transactions (product_id, amount, reason) VALUES (2, 35, 'compra_fornecedor'); -- Teclado
INSERT INTO transactions (product_id, amount, reason) VALUES (3, 50, 'compra_fornecedor'); -- Mouse
INSERT INTO transactions (product_id, amount, reason) VALUES (4, 4, 'compra_fornecedor'); -- Cadeira
INSERT INTO transactions (product_id, amount, reason) VALUES (5, 30, 'compra_fornecedor'); -- Headset
INSERT INTO transactions (product_id, amount, reason) VALUES (6, 5, 'compra_fornecedor'); -- Webcam
INSERT INTO transactions (product_id, amount, reason) VALUES (7, 100, 'compra_fornecedor'); -- Mousepad

--! Adicionando transações de venda, as orders e order_items:

BEGIN;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (3, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, -5, 'venda_cliente', 1);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 1, id, ABS(-5), price
FROM products
WHERE id=1;
UPDATE products SET quantity = quantity + (-5) WHERE id = 1;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (1, 'pendente', 'client' );
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, -5, 'venda_cliente', 2);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 2, id, ABS(-5), price
FROM products
WHERE id=1;
UPDATE products SET quantity = quantity + (-5) WHERE id = 1;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (2, 'pago', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (3, -10, 'venda_cliente', 3);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 3, id, ABS(-10), price
FROM products
WHERE id=3;
UPDATE products SET quantity = quantity + (-10) WHERE id = 3;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (3, 'enviado', 'admin');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (4, -2, 'venda_cliente', 4);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 4, id, ABS(-2), price
FROM products
WHERE id=4;
UPDATE products SET quantity = quantity + (-2) WHERE id = 4;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (4, 'entregue', 'admin');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (5, -8, 'venda_cliente', 5);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 5, id, ABS(-8), price
FROM products
WHERE id=5;
UPDATE products SET quantity = quantity + (-8) WHERE id = 5;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (5, 'pago', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (6, -3, 'venda_cliente', 6);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 6, id, ABS(-3), price
FROM products
WHERE id=6;
UPDATE products SET quantity = quantity + (-3) WHERE id = 6;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (1, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (7, -15, 'venda_cliente', 7);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 7, id, ABS(-15), price
FROM products
WHERE id=7;
UPDATE products SET quantity = quantity + (-15) WHERE id = 7;

COMMIT;

--? C:
--*1
SELECT * from products WHERE quantity<5;
--*2
SELECT SUM(price * quantity) AS valor_total_estoque FROM products;
--*3
SELECT * from transactions ORDER BY date_hour DESC LIMIT 5;
--*4
SELECT * from transactions WHERE product_id=2;


--? C:
--*1 (Se fosse fazer pelo nome, seria muito trabalho sem sentido)
SELECT * FROM orders WHERE client_id=3;
--*2
SELECT unit_price * quantity AS total FROM order_items GROUP BY order_id;
--*3
SELECT orders.client_id, order_items.unit_price * order_items.quantity AS total 
FROM order_items
JOIN orders ON order_items.id = orders.id 
GROUP BY client_id 
ORDER BY total DESC;
--*4
SELECT orders.id, orders.date_hour, orders.status, orders.client_id, clients.name, clients.email, clients.date_of_registration
FROM orders 
JOIN order_items ON orders.id = order_items.id 
JOIN clients ON clients.id = orders.client_id
WHERE order_items.product_id = 1;
 
ALTER TABLE orders
ADD COLUMN last_modified_by TEXT;
ALTER TABLE orders
ADD COLUMN last_modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

--! Pra mudar o status de um pedido (pendente, pago, enviado, entregue): 
BEGIN;

UPDATE orders SET status='pago' WHERE orders.id = 1;

COMMIT;

--! Pra cancelar um pedido:
BEGIN;

UPDATE orders SET status='cancelado' WHERE id=1;
UPDATE products 
SET quantity = quantity + COALESCE(
    (SELECT quantity FROM order_items WHERE order_id = 1 AND product_id = products.id),
   0
)
WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, 5, 'estorno_cancelamento', 1);

COMMIT;



UPDATE orders 
SET last_modification_date = CURRENT_TIMESTAMP 
WHERE last_modification_date IS NULL;

-- ALTER TABLE orders ADD COLUMN last_modification_date TIMESTAMP;
--     UPDATE orders 
--     SET last_modification_date = CURRENT_TIMESTAMP 
--     WHERE id = 1;

-- CONTINUAR A PARTIR DO NUMERO 3 DO NIVEL 3 E CRIAR UMA TABELA DE LOG DE ALTERAÇOES DE PEDIDO
--! Criar table ORDER_EVENTS e alterar a inclusão das transactions para que adicione dados nessa tabela também (E recriar table TRANSACTIONS).