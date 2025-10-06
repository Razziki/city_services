class Service < ApplicationRecord
  has_many :facility_services, dependent: :destroy
  has_many :facilities, through: :facility_services

  validates :name, presense: true, uniqueness: { scope: :category }
  validates :category, presence: true
end
