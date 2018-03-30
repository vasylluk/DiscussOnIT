class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.integer :question_id, foreign_key: true
      t.integer :category_id, foreign_key: true

      t.timestamps
    end
  end
end
