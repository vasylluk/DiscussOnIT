class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :user_id
      t.string :resource_type
      t.integer :resource_id
      t.string :text
      t.boolean :view , default: false

      t.timestamps
    end
  end
end
