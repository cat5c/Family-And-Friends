class RemoveUrlFromPicture < ActiveRecord::Migration[5.1]
  def change
  	remove_column :pictures, :url
  end
end
