class AddMaterialToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :material, index: true
  end
end
