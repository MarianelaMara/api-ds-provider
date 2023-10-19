class Maker < ApplicationRecord
    has_many :calendars
    has_many :years, through: :calendars
    has_many :bookings, as: :provider

    validates_uniqueness_of :name

    def self.available_between(start_date, end_date)
      # Convertir las fechas a objetos Date
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)  
      # Obtener el año inicial y final del rango de fechas
      start_year = start_date.year
      end_year = end_date.year
      joins(:calendars).where("calendars.year BETWEEN ? AND ?", start_year, end_year).where("calendars.free_dates && ARRAY[?]::date[]", (start_date..end_date).to_a).distinct
    end

  end