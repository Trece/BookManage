class CreateBooks < ActiveRecord::Migration
  def up
  	create_table :books do |t|
      t.string :name
      t.string :ISBN
      t.text :description
      t.integer :total
      t.integer :remain

      t.timestamps
    end
  end

  def down
  	drop_table :books
  end
end
