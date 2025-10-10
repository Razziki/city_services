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
    name: row["city"].to_s.strip,
    province: row["province_name"].to_s.strip,
    country: "Canada",
    lat: row["lat"],
    lng: row["lng"]
  )
  inserted += 1
end

puts "Seed sample facilities and services"

# Create service categories, names. At the end I realized faker was not giving me realistic matches so I created my own.
service_data = {
  "Automotive" => [ "Oil Change", "Brake Service", "Battery Replacement" ],
  "Beauty"     => [ "Haircut", "Spa Treatment", "Nail Salon" ],
  "Health"     => [ "Physiotherapy", "Dental Checkup", "Massage Therapy" ],
  "Home"       => [ "Plumbing", "Electrical Repair", "House Cleaning" ],
  "Outdoors"   => [ "Landscaping", "Snow Removal", "Lawn Care" ],
  "Food"       => [ "Catering", "Bakery", "Meal Delivery" ],
  "Education"  => [ "Tutoring", "Music Lessons", "Language Classes" ],
  "Sports"     => [ "Personal Training", "Yoga Class", "Swim Lessons" ],
  "Travel"     => [ "Car Rental", "Tour Guide", "Airport Shuttle" ]
}

# Create the sercives
service_data.each do |category, names|
  names.each do |name|
    Service.find_or_create_by!(name: name, category: category)
  end
end

services = Service.all

# Create multiple facilities per city, each with random services
City.find_each do |city|
  number_of_facilities = rand(2..4)

  number_of_facilities.times do
    facility = city.facilities.create!(
      name: "#{Faker::Company.name} Facility",
      address: Faker::Address.street_address,
      lat: city.lat.to_f + rand(-0.01..0.01),
      lng: city.lng.to_f + rand(-0.01..0.01)
    )

    number_of_services = rand(2..5)
    selected_services = services.sample(number_of_services)

    selected_services.each do |service|
      FacilityService.find_or_create_by!(facility: facility, service: service)
    end
  end
end

puts "Faker data added successfully!"
