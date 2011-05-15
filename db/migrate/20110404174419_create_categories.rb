class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name, :string
      
      t.timestamps
    end
    Category.create :name => "News"
    Category.create :name => "Travles"
    Category.create :name => "Adventures"
    
    add_column :posts, :category_id, :integer
      Post.find(:all).each do |c|
        c.update_attribute(:category_id, 4)
      end
  end

  def self.down
    drop_table :categories
  end
end
