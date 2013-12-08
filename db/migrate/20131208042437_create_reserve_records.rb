class CreateReserveRecords < ActiveRecord::Migration
  def change
    create_table :reserve_records do |t|
      t.integer :reader_id
      t.integer :book_id

      t.timestamps
    end
  end
end
