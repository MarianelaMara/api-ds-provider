class Material < ApplicationRecord
    has_many :provisions
    has_many :providers, through: :provisions

    validates_uniqueness_of :name
end