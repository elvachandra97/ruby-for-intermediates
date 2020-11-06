require './db/mysql_connector.rb'
require './models/item.rb'

class Category
    attr_accessor :name, :id
    def initialize(params)
        @name = params[:name]
        @id = params[:id]
    end

    def self.get_all_categories
        client = create_db_client
        raw_data = client.query("SELECT * FROM categories")
        categories = Array.new
        raw_data.each do |data|
           category = Category.new(data['name'], data['id'])
           categories.push(category)
        end
        categories
    end

    def self.get_category(id)
        client = create_db_client
        category = client.query("SELECT * FROM categories WHERE id = #{id}")
        category
    end

    def self.get_items_by_category(id)
        client = create_db_client
        items = Array.new
        raw_data = client.query("
            SELECT i.id, i.name, i.price
            FROM items i 
            LEFT JOIN item_categories ic ON ic.item_id = i.id 
            WHERE ic.item_id = #{id}
            ")
        raw_data.each do |data|
           item = Item.new(data['name'], data['price'], data['id'])
           items.push(item)
        end
        categories

    end

    def save_create_category
        return false unless valid?

        client = create_db_client
        client.query("INSERT INTO categories (name) VALUES ('#{name}')")
    end
    
    def self.save_edit_category(id, name)
        return false unless valid?
        
        client = create_db_client
        client.query("UPDATE categories SET name = '#{name}' WHERE id = #{id}")
    end
    
    def self.save_delete_category(id)
        client = create_db_client
        client.query("DELETE FROM categories WHERE id = #{id}")
    end

    def valid?
        return false if @name.nil?
        true
    end
end