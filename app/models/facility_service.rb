class FacilityService < ApplicationRecord
  belongs_to :facility
  belongs_to :service

  validates :facility_id, uniqueness: { scope: :service_id }
end
