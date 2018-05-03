class CreateUserTags < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tags do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :score,default: 0

      t.timestamps
    end
  end
end
