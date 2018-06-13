class CreateUserparams < ActiveRecord::Migration[5.1]
  def change
    create_table :userparams do |t|
      t.integer :user_id
      t.string :bio
      t.string :country
      t.string :univ
      t.string :phone
      t.integer :karma, default: 0
      t.boolean :filter,default: false  
      t.timestamps
    end
  end
end
