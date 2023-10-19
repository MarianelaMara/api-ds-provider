class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :country
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
