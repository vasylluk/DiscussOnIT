class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :text
      t.integer :score
      t.boolean :right , default: false

      t.timestamps
    end
  end
end
