class UpdateUsersTableWithSpotifyInfo < ActiveRecord::Migration
  def change
    add_column :users, :id, :string, null: false 
    add_column :users, :display_name, :string, null: true 
    add_column :users, :email, :string, null: true 
  end
end
