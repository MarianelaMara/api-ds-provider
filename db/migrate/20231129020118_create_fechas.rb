class CreateFechas < ActiveRecord::Migration[7.0]
  def change
    create_table :fechas do |t|
      t.integer :bonita_c_id, null: false
      t.text :arreglo, array: true, default: []
      t.timestamps
    end
  end
end
