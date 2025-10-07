# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"
require "faker"

csv_path = Rails.root.join("db/csv/canadacities.csv")

puts "Importing Cities..."
inserted = 0

CSV.foreach(csv_path, headers: true).first(50).each do |row|
  city = City.find_or_create_by!(
    name: row["city"],
    province: row["province_name"],
    country: "Canada",
    lat: row["lat"],
    lng: row["lng"]
  )
  inserted += 1
end

puts "Cities imported: #{inserted}"

City.find_each do |city|
  next if city.facilities.exists?  

puts "Seed sample facilities"
City.find_each do |city|
  facility = city.facilities.create!(
    name: "#{Faker::Company.name} Facility",
    address: Faker::Address.street_address,
    lat: city.lat.to_f + rand(-0.01..0.01), # to have the facility locations somewhat within the city
    lng: city.lng.to_f + rand(-0.01..0.01)  # to have the facility locations somewhat within the city
  )


  # Create a few random services for each facility
  2.times do
    service = Service.find_or_create_by!(
      name: Faker::Commerce.department(max: 1, fixed_amount: true),
      category: Faker::Commerce.material
    )
    FacilityService.find_or_create_by!(facility: facility, service: service)
  end
end

puts "Faker data added!"
