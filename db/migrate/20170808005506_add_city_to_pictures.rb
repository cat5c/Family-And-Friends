class AddCityToPictures < ActiveRecord::Migration[5.1]
  def change
    add_reference :pictures, :city, foreign_key: true
  end
end
