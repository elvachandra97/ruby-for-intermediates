1. 
SELECT i.id, i.name, i.price, c.name 
FROM items i 
LEFT JOIN item_categories ic ON ic.item_id = i.id 
LEFT JOIN categories c ON c.id =ic.category_id;

2. 
SELECT i.id, i.name, i.price, c.name 
FROM items i 
INNER JOIN item_categories ic ON ic.item_id = i.id 
INNER JOIN categories c ON c.id =ic.category_id 
WHERE c.name = 'Main Dish';

3. 
SELECT i.id, i.name, i.price 
FROM items i 
LEFT JOIN item_categories ic ON ic.item_id = i.id 
LEFT JOIN categories c ON c.id =ic.category_id 
WHERE c.name = 'Main Dish' 
AND i.price > 30000;

4.
SELECT i.name 
FROM items i 
LEFT JOIN item_categories ic ON ic.item_id = i.id 
LEFT JOIN categories c ON c.id =ic.category_id 
WHERE c.name IS NULL;

4.
SELECT i.name 
FROM items i 
LEFT JOIN item_categories ic ON ic.item_id = i.id 
WHERE ic.category_id IS NULL;

5.
SELECT c.id, c.name, GROUP_CONCAT(i.name SEPARATOR ', ') AS Dishes, MAX(i.price) AS Max_Price
FROM items i 
INNER JOIN item_categories ic ON ic.item_id = i.id 
INNER JOIN categories c ON c.id =ic.category_id 
GROUP BY c.id;

ALTER TABLE item_categories MODIFY item_id INT NOT NULL;
ALTER TABLE item_categories MODIFY category_id INT NOT NULL;
ALTER TABLE item_categories ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE item_categories ADD FOREIGN KEY (category_id) REFERENCES categories(id);
CREATE UNIQUE INDEX name ON categories (name);