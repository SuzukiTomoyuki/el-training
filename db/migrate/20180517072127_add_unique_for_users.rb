class AddUniqueForUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :users, [:name, :email], :unique => true
  end
end
