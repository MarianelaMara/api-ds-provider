class AddAasmStateToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :aasm_state, :string
  end
end
