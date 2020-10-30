require 'mysql2'
require './item.rb'
require './category.rb'

def create_db_client
    client = Mysql2::Client.new(
        :host => 'localhost',
        :username => 'angelchandra',
        :password => 'angelicA97!',
        :database => 'food_oms_db'
    )
    client
end

def get_all_items
    client = create_db_client
    raw_data = client.query("SELECT * FROM items")
    items = Array.new
    raw_data.each do |data|
        item = Item.new(data['name'], data['price'], data['id'])
        items.push(item)
    end
    items
end

def get_all_categories
    client = create_db_client
    raw_data = client.query("SELECT * FROM categories")
    categories = Array.new
    raw_data.each do |data|
        category = Category.new(data['name'], data['id'])
        categories.push(category)
    end
    categories
end

def get_item(id)
    client = create_db_client
    item = Array.new
    raw_data = client.query("
        SELECT i.id, i.name, i.price, c.name AS category_name, c.id AS category_id
        FROM items i 
        LEFT JOIN item_categories ic ON ic.item_id = i.id 
        LEFT JOIN categories c ON c.id =ic.category_id 
        WHERE i.id = #{id}
    ")
    raw_data.each do |data|
        category = Category.new(data['category_name'], data['category_id'])
        item = Item.new(data['name'], data['price'], data['id'], category)
    end
    item
end

def create_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items (name, price) VALUES ('#{name}', '#{price}')")
end

def edit_item(id, name, price)
    client = create_db_client
    client.query("UPDATE items SET name = '#{name}', price = '#{price}' WHERE id = #{id}")
end

def delete_item(id)
    client = create_db_client
    client.query("DELETE FROM items WHERE id = #{id}")
end