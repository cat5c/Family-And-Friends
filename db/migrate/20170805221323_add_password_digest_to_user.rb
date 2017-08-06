class AddPasswordDigestToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :password_digest, :string
  	add_column :users, :name, :string
  	remove_column :users, :password
  end
end
