class AddingAllThingsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :uid, :string
    change_column :users, :display_name, :string
    change_column :users, :email, :string
    change_column :users, :provider, :string
end
