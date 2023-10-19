class Provider < ApplicationRecord
    has_many :provisions
    has_many :materials, through: :provisions
    has_many :bookings, as: :provider

    validates_uniqueness_of :name

    def as_json(options = {})
        super(options.merge( { except: [:created_at, :updated_at] }))
    end
end