class ChangeColumnDefaultQuest < ActiveRecord::Migration[5.1]
  def change
  	change_column :questions, :count, :integer, :default => 0

  end
end
