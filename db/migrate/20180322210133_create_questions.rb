class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :text
      t.integer :count
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
