require './models/item.rb'
require './models/category.rb'

class ItemController
   def get_all_items
      items = Item.get_all_item()
      renderer = ERB.new(File.read("./views/items/list.erb"))
      renderer.result(binding)
   end

   def get_item_by_id(params)
      id = params['id']
      item = Item.get_item(id)
      renderer = ERB.new(File.read("./views/items_detail.erb"))
      renderer.result(binding)
   end

   def create_item_page
      categories = Category.get_all_categories()
      renderer = ERB.new(File.read("./views/items/create.erb"))
      renderer.result(binding)
   end

   def create_item(params)
      item = Item.new({
         name: params['name'],
         price: params['price']
         category: params['category']
      })
      item.save_create_item
      renderer = ERB.new(File.read("./views/items/list.erb"))
      renderer.result(binding)
   end

   def edit_item_page(params)
      id = params['id']
      item = Item.get_item(id)
      categories = get_all_categories
      renderer = ERB.new(File.read("./views/items/edit.erb"))
      renderer.result(binding)
   end

   def edit_item(params)
      id = params['id']
      name = params['name']
      price = params['price']
      category = params['category']
      Item.save_edit_item(id, name, price, category)
      renderer = ERB.new(File.read("./views/items/list.erb"))
      renderer.result(binding)
   end

   def delete_item(params)
      id = params['id']
      Item.save_delete_item(id)
      renderer = ERB.new(File.read("./views/items/list.erb"))
      renderer.result(binding)
   end
end