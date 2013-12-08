class AddUserIdToReader < ActiveRecord::Migration
  def change
    add_column :readers, :user_id, :integer
  end
end
