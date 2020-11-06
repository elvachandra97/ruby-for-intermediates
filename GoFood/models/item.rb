require './db/mysql_connector.rb'
require './models/category.rb'

class Item
   attr_accessor :name, :price, :id, :category
   def initialize(params)
      @name = param[:name]
      @price = param[:price]
      @id = param[:id]
      @category = param[:category]
   end

   def self.get_all_items
      client = create_db_client
      raw_data = client.query("SELECT * FROM items")
      items = Array.new
      raw_data.each do |data|
         item = Item.new(data['name'], data['price'], data['id'])
         items.push(item)
      end
      items
   end

   def self.get_item(id)
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

   def save_create_item
      return false unless valid?

      client = create_db_client
      client.query("INSERT INTO items (name, price) VALUES ('#{name}', '#{price}')")
      client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{id}', '#{category}')")
      end
   end

   def self.save_edit_item(id, name, price, category)
      return false unless valid?

      client = create_db_client
      client.query("UPDATE items SET name = '#{name}', price = '#{price}' WHERE id = #{id}")
      client.query("UPDATE item_categories SET category_id = '#{category}' WHERE id = #{id}")
   end

   def self.save_delete_item(id)
      client = create_db_client
      client.query("DELETE FROM items WHERE id = #{id}")
      client.query("DELETE FROM items_categories WHERE item_id = #{id}")
   end

   def valid?
      return false if @name.nil?
      return false if @price.nil?
      return false if @category.nil?
      true
   end
end