class CreatePostVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :post_votes do |t|
      t.integer :post_id
      t.integer :score, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
