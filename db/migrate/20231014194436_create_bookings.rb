class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :provider, polymorphic: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end

end
