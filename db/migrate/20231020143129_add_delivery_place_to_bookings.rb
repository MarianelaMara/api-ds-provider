class AddDeliveryPlaceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :delivery_place, :string
  end
end
