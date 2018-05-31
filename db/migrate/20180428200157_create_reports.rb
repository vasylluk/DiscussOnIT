class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.string :type
      t.string :text

      t.timestamps
    end
  end
end
