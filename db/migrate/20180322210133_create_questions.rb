class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :text
      t.integer :count
<<<<<<< HEAD
=======
      t.integer :score
>>>>>>> d8d478cc919bde9fb16fdafd7e6e4d1f63d64487
      t.integer :user_id

      t.timestamps
    end
  end
end
