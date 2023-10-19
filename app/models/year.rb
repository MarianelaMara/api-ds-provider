class Year < ApplicationRecord
    has_many :calendars
    has_many :makers, through: :calendars
  end