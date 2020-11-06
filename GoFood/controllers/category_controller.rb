require './models/item.rb'
require './models/category.rb'

class CategoryController
   def get_all_categories
      categories = Category.get_all_categories()
      renderer = ERB.new(File.read("./views/categories/list.erb"))
      renderer.result(binding)
   end

   def get_items_by_category(params)
      id = params['id']
      items = Category.get_items_by_category(id)
      renderer = ERB.new(File.read("./views/categories/list_of_items.erb"))
      renderer.result(binding)
   end

   def create_category_page
      renderer = ERB.new(File.read("./views/categories/create.erb"))
      renderer.result(binding)
   end

   def create_category(params)
      category = Category.new({
         name: params['name']
      })
      category.save_create_category
      renderer = ERB.new(File.read("./views/categories/list.erb"))
      renderer.result(binding)
   end

   def edit_category_page(params)
      id = params['id']
      category = Category.get_category(id)
      renderer = ERB.new(File.read("./views/categories/edit.erb"))
      renderer.result(binding)
   end

   def edit_category(params)
      id = params['id']
      name = params['name']
      Category.save_edit_category(id, name)
      renderer = ERB.new(File.read("./views/categories/list.erb"))
      renderer.result(binding)
   end

   def delete_category(params)
      id = params['id']
      Category.save_delete_category(id)
      renderer = ERB.new(File.read("./views/categories/list.erb"))
      renderer.result(binding)
   end
end