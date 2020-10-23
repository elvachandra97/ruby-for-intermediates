2.
CREATE TABLE customer(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(50),
    phone varchar(20),
    PRIMARY KEY (id)
);

CREATE TABLE orders(
    id int NOT NULL AUTO_INCREMENT, 
    order_date DATE, 
    customer_id int NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE order_details(
    order_id int NOT NULL,
    item_id int NOT NULL,
    quantity int DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

3.
INSERT INTO customer (name, phone) VALUES
('Budiawan', 012345678),
('Budiawan', 089753124),
('Mary Jones', 087654321),
('Angel', 081320613369),
('Lala', 08132675046)
;

INSERT INTO orders (order_date, customer_id) VALUES
('2020-10-21 09:25:55', 1),
('2020-10-21 12:11:10', 2),
('2020-10-22 16:54:30', 4),
('2020-10-22 18:46:14', 3),
('2020-10-23 10:23:10', 1)
;

INSERT INTO order_details (order_id, item_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 6, 1),
(3, 3, 1),
(3, 9, 2),
(4, 3, 1),
(4, 6, 2),
(5, 8, 1),
(5, 7, 1)
;

4.
SELECT 
    o.id AS Order_ID, 
    o.order_date AS Order_Date, 
    c.name AS Customer_Name, 
    CONCAT('+62', c.phone) AS Customer_Phone, 
    SUM(i.price * od.quantity) AS Total,
    GROUP_CONCAT(i.name SEPARATOR ', ') AS Items_Bought
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customer c ON c.id = o.customer_id
INNER JOIN items i ON i.id = od.item_id
GROUP BY o.id