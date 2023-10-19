class CreateProvisions < ActiveRecord::Migration[7.0]
  def change
    create_table :provisions do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.decimal :price
      t.integer :stock
      t.integer :delivery_time

      t.timestamps
    end
  end
end
