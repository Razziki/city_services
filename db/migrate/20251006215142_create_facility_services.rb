class CreateFacilityServices < ActiveRecord::Migration[8.0]
  def change
    create_table :facility_services do |t|
      t.references :facility, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
