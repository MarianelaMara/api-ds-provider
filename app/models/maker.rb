class Maker < ApplicationRecord
  
    has_many :bookings, as: :provider

    validates_uniqueness_of :name
    attribute :price, :decimal, precision: 10, scale: 2

    def self.available_between(start_date, end_date)
      left_joins(:bookings).where("bookings.provider_id IS NULL OR (bookings.start_date > ? OR bookings.end_date < ?)", end_date, start_date).distinct    
    end

    def as_json(options = {})
      super(options.merge( { except: [:created_at, :updated_at] }))
  end

  end