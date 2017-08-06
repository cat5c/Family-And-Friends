class DropComments < ActiveRecord::Migration[5.1]
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.text :contents
      t.references :users
      t.references :pictures

      t.timestamps        
    end
    add_index :users, :pictures
  end
end
