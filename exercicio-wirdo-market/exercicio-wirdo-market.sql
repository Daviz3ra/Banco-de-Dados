CREATE TABLE IF NOT EXISTS 'products' (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  price REAL NOT NULL,
  quantity INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS 'transactions' (
  date_hour TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount NUMERIC NOT NULL,
  reason TEXT NOT NULL,
  product_id INTEGER NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
)

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

-- Entradas (Compra de Fornecedor)
INSERT INTO transactions (product_id, amount, reason) VALUES (1, 20, 'compra_fornecedor'); -- Monitor
INSERT INTO transactions (product_id, amount, reason) VALUES (2, 35, 'compra_fornecedor'); -- Teclado
INSERT INTO transactions (product_id, amount, reason) VALUES (3, 50, 'compra_fornecedor'); -- Mouse
INSERT INTO transactions (product_id, amount, reason) VALUES (4, 4, 'compra_fornecedor'); -- Cadeira
INSERT INTO transactions (product_id, amount, reason) VALUES (5, 30, 'compra_fornecedor'); -- Headset
INSERT INTO transactions (product_id, amount, reason) VALUES (6, 5, 'compra_fornecedor'); -- Webcam
INSERT INTO transactions (product_id, amount, reason) VALUES (7, 100, 'compra_fornecedor'); -- Mousepad


BEGIN;

INSERT INTO transactions (product_id, amount, reason) VALUES (1, -5, 'venda_cliente');
UPDATE products SET quantity = quantity + (-5) WHERE id = 1;
INSERT INTO orders(client_id, status) VALUES (3, 'pendente')
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 100, id, 2, price 
FROM products 
WHERE id = 3;

COMMIT;

-- C:
SELECT * from products WHERE quantity<5; --1
SELECT SUM(price * quantity) AS valor_total_estoque FROM products; --2
SELECT * from transactions ORDER BY date_hour DESC LIMIT 5; --3
SELECT * from transactions WHERE product_id=2; --4

CREATE TABLE IF NOT EXISTS 'clients' (
id INTEGER PRIMARY KEY AUTOINCREMENT, 
name TEXT NOT NULL, 
email TEXT UNIQUE NOT NULL, 
date_of_registration DATE DEFAULT CURRENT_DATE
)

--CONTINUAR: criar table orders e adicionar o processo de inserir uma order nessa table quando é feito um insert into transactions (RETORNAR A PARTIR DO EXERCICIO 2 DO NIVEL 2)
CREATE TABLE IF NOT EXISTS 'orders' (
id INTEGER PRIMARY KEY AUTOINCREMENT, 
date_hour DEFAULT CURRENT_TIMESTAMP, 
client_id INTEGER NOT NULL, 
status TEXT NOT NULL CHECK(status IN ('pendente', 'pago', 'enviado', 'entregue', 'cancelado')),
FOREIGN KEY (client_id) REFERENCES clients(id)
)

CREATE TABLE order_items(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
)