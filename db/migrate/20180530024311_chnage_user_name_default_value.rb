class ChnageUserNameDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :image_name, :string, default: "default_user.png"
  end
end
