class UpdateUsersToNotNull < ActiveRecord::Migration
  def change
    change_column_null :users, :uid, :string, true 
    change_column_null :users, :display_name, :string, true 
    change_column_null :users, :email, :string, true 
    change_column_null :users, :provider, :string, true 
  end
end
