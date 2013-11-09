class AddColumnsToBook < ActiveRecord::Migration
  def change
    add_column :books, :total_num, :integer
    add_column :books, :remain_num, :integer
  end
end
