class CreateFacilities < ActiveRecord::Migration[8.0]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
