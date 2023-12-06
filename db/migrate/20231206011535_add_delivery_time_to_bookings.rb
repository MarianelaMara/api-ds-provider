class AddDeliveryTimeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :delivery_time, :integer
  end
end
