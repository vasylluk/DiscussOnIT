class ChangeColumnDefaultAns < ActiveRecord::Migration[5.1]
  def change
  	change_column :answers, :score, :integer, :default => 0

  end
end
