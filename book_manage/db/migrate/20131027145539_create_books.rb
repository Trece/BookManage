class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :ISBN
      t.text :description
      t.integer :total
      t.integer :remain

      t.timestamps
    end
  end
end
