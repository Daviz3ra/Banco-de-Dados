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
);

CREATE TABLE IF NOT EXISTS 'orders' (
id INTEGER PRIMARY KEY AUTOINCREMENT, 
created_at DEFAULT CURRENT_TIMESTAMP, 
client_id INTEGER NOT NULL, 
status TEXT NOT NULL CHECK(status IN ('pendente', 'pago', 'enviado', 'entregue', 'cancelado')),
last_modified_by TEXT NOT NULL,
last_modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE IF NOT EXISTS 'transactions' (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount NUMERIC NOT NULL,
  reason TEXT NOT NULL,
  product_id INTEGER NOT NULL,
  order_id INTEGER,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS 'order_items'(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS 'order_events'(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  order_id INTEGER NOT NULL,
  old_value TEXT,
  new_value TEXT NOT NULL,
  modified_by TEXT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

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

--! Resetando produtos e transações de entrada:
UPDATE products SET quantity = 20 WHERE id = 1;
UPDATE products SET quantity = 35 WHERE id = 2;
UPDATE products SET quantity = 50 WHERE id = 3;
UPDATE products SET quantity = 4 WHERE id = 4;
UPDATE products SET quantity = 30 WHERE id = 5;
UPDATE products SET quantity = 5 WHERE id = 6;
UPDATE products SET quantity = 100 WHERE id = 7;

INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, 20, 'compra_fornecedor', NULL); -- Monitor
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (2, 35, 'compra_fornecedor', NULL); -- Teclado
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (3, 50, 'compra_fornecedor', NULL); -- Mouse
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (4, 4, 'compra_fornecedor', NULL); -- Cadeira
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (5, 30, 'compra_fornecedor', NULL); -- Headset
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (6, 5, 'compra_fornecedor', NULL); -- Webcam
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (7, 100, 'compra_fornecedor', NULL); -- Mousepad

--! Adicionando transações de venda, as orders e order_items:

BEGIN;

INSERT INTO orders(client_id, status, last_modified_by) VALUES (3, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, -5, 'venda_cliente', 1);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 1, id, ABS(-5), price
FROM products
WHERE id = 1;
UPDATE products SET quantity = quantity + (-5) WHERE id = 1;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (1, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (1, 'pendente', 'client' );
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (1, -5, 'venda_cliente', 2);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 2, id, ABS(-5), price
FROM products
WHERE id = 1;
UPDATE products SET quantity = quantity + (-5) WHERE id = 1;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (2, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (2, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (3, -10, 'venda_cliente', 3);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 3, id, ABS(-10), price
FROM products
WHERE id = 3;
UPDATE products SET quantity = quantity + (-10) WHERE id = 3;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (3, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (3, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (4, -2, 'venda_cliente', 4);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 4, id, ABS(-2), price
FROM products
WHERE id = 4;
UPDATE products SET quantity = quantity + (-2) WHERE id = 4;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (4, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (4, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (5, -8, 'venda_cliente', 5);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 5, id, ABS(-8), price
FROM products
WHERE id = 5;
UPDATE products SET quantity = quantity + (-8) WHERE id = 5;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (5, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (5, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (6, -3, 'venda_cliente', 6);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 6, id, ABS(-3), price
FROM products
WHERE id = 6;
UPDATE products SET quantity = quantity + (-3) WHERE id = 6;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (6, NULL, 'pendente', 'client');

INSERT INTO orders(client_id, status, last_modified_by) VALUES (1, 'pendente', 'client');
INSERT INTO transactions (product_id, amount, reason, order_id) VALUES (7, -15, 'venda_cliente', 7);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 7, id, ABS(-15), price
FROM products
WHERE id = 7;
UPDATE products SET quantity = quantity + (-15) WHERE id = 7;
INSERT INTO order_events(order_id, old_value, new_value, modified_by) VALUES (7, NULL, 'pendente', 'client');

COMMIT;

--? Exercícios C(1):
--*1
SELECT * from products WHERE quantity<5;
--*2
SELECT SUM(price * quantity) AS valor_total_estoque FROM products;
--*3
SELECT * from transactions ORDER BY created_at DESC LIMIT 5;
--*4
SELECT * from transactions WHERE product_id = 2;


--? Exercícios C(2):
--*1 (Se fosse fazer pelo nome, seria muito trabalho sem sentido)
SELECT * FROM orders WHERE client_id = 3;
--*2
SELECT unit_price * quantity AS total FROM order_items GROUP BY order_id;
--*3
SELECT orders.client_id, order_items.unit_price * order_items.quantity AS total 
FROM order_items
JOIN orders ON order_items.id = orders.id 
GROUP BY client_id 
ORDER BY total DESC;
--*4
SELECT orders.id, orders.created_at, orders.status, orders.client_id, clients.name, clients.email, clients.date_of_registration
FROM orders 
JOIN order_items ON orders.id = order_items.id 
JOIN clients ON clients.id = orders.client_id
WHERE order_items.product_id = 1;

--! Pra mudar o status de um pedido para pago:
BEGIN;

INSERT INTO order_events(order_id, old_value, new_value, modified_by) 
SELECT 1, new_value, 'pago', 'client'
FROM order_events
WHERE order_id = 1
ORDER BY id DESC
LIMIT 1;
UPDATE orders SET status = 'pago', last_modified_by = 'client', last_modification_date = CURRENT_TIMESTAMP 
WHERE orders.id = 1;

COMMIT;

--! Pra mudar o status de um pedido para enviado: 

BEGIN;

INSERT INTO order_events(order_id, old_value, new_value, modified_by) 
SELECT 1, new_value, 'enviado', 'admin'
FROM order_events
WHERE order_id = 1
ORDER BY id DESC
LIMIT 1;
UPDATE orders SET status = 'enviado', last_modified_by = 'admin', last_modification_date = CURRENT_TIMESTAMP 
WHERE orders.id = 1;

COMMIT;

--! Pra mudar o status de um pedido para entregue: 

BEGIN;

INSERT INTO order_events(order_id, old_value, new_value, modified_by) 
SELECT 1, new_value, 'entregue', 'admin'
FROM order_events
WHERE order_id = 1
ORDER BY id DESC
LIMIT 1;
UPDATE orders SET status = 'entregue', last_modified_by = 'admin', last_modification_date = CURRENT_TIMESTAMP 
WHERE orders.id = 1;

COMMIT;

--! Pra cancelar um pedido:
BEGIN;


INSERT INTO order_events(order_id, old_value, new_value, modified_by) 
SELECT 1, new_value, 'cancelado', 'client'
FROM order_events
WHERE order_id = 1
ORDER BY id DESC
LIMIT 1;
UPDATE orders SET status = 'cancelado', last_modified_by = 'client', last_modification_date = CURRENT_TIMESTAMP 
WHERE id = 1;
UPDATE products 
SET quantity = quantity + (
    SELECT COALESCE(SUM(quantity), 0)
    FROM order_items 
    WHERE order_id = 1 AND product_id = products.id
)
WHERE id IN (
  SELECT product_id 
  FROM order_items 
  WHERE order_id = 1);
INSERT INTO transactions (product_id, amount, reason, order_id) 
VALUES (1, 5, 'estorno_cancelamento', 1);

COMMIT;

--? Exercícios C(3):
--*1
SELECT product_id, amount FROM transactions WHERE reason = 'estorno_cancelamento' AND order_id = 1;
--*2
SELECT '2026-05' AS 'year-month', COUNT(orders.id) AS orders_total, SUM(order_items.quantity*order_items.unit_price) AS total_value, SUM(order_items.quantity) AS sold_items, (SUM(order_items.quantity*order_items.unit_price)/COUNT(orders.id)) AS avg_value_by_order
FROM order_items 
JOIN orders ON order_items.order_id = orders.id
WHERE orders.status != 'cancelado' AND strftime('%Y-%m', orders.created_at) = '2026-05'
--*3
SELECT products.name 
FROM products
WHERE products.id NOT IN (
  SELECT order_items.product_id FROM order_items 
  JOIN orders ON orders.id = order_items.id
  WHERE orders.created_at >= DATETIME('now', '-30 days') AND orders.status != 'cancelado'
);
--*4
SELECT * FROM order_events WHERE order_id IN(
SELECT order_id FROM order_events WHERE new_value = 'cancelado'
)
ORDER BY order_id, created_at;