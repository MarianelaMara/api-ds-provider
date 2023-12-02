class ChangeEndDateAndStartDateToDatetimeInBookings < ActiveRecord::Migration[7.0]
  def change # Cambiar el tipo de dato de end_date a datetime 
    change_column :bookings, :end_date, :datetime # Cambiar el tipo de dato de start_date a datetime 
    change_column :bookings, :start_date, :datetime 
  end
end
