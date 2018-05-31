class AddImageNameForUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_name, :string, default: nil
  end
end
