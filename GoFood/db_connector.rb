require 'mysql2'
require './item.rb'

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

def create_new_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items (name, price) VALUES ('#{name}', '#{price}')")
end