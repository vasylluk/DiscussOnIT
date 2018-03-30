class ChangeColumnDefaultCat < ActiveRecord::Migration[5.1]
  def change
  	change_column :categories, :count, :integer, :default => 0
  end
end
