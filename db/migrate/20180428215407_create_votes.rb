class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.string :resource_type
      t.integer :resource_id
      t.integer :score

      t.timestamps
    end
  end
end
