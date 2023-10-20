class Material < ApplicationRecord
    has_many :provisions
    has_many :providers, through: :provisions
    has_many :bookings, as: :provider

    validates_uniqueness_of :name
end