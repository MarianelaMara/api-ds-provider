class AddCaseIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :case_id, :integer
  end
end
