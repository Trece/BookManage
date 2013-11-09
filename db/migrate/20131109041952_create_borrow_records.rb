class CreateBorrowRecords < ActiveRecord::Migration
  def change
    create_table :borrow_records do |t|
      t.integer :reader_id
      t.integer :book_id

      t.timestamps
    end
  end
end
