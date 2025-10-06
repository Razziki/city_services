class City < ApplicationRecord
  has_many :facilities, dependent: :destroy # delete on cascade

  validates :name, :province, :country, presence: true
  validates :lat, :lng, numericality: true, allow_nil: true
end
