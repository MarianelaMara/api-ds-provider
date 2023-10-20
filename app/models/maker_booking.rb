class MakerBooking < ApplicationRecord
  belongs_to :maker
  belongs_to :booking
end
