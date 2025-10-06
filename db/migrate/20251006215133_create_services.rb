class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
    add_index :services, :name
  end
end
