class CreateCalendarios < ActiveRecord::Migration[7.0]
  def change
    create_table :calendarios do |t|
      t.references :maker, null: false, foreign_key: true
      t.integer :year
      t.date :free_dates, array: true, default: []
      t.date :booked_dates, array: true, default: []
    end
  end
end
