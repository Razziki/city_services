class Facility < ApplicationRecord
  belongs_to :city
  has_many :facility_services, dependent: :destroy
  has_many :services, through: :facility_services

  validates :name, :address, presence: true
  validates :lat, :lng, numericality: true, allow_nil: true
end
