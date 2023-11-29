class RenameBonitaCIdToBonita < ActiveRecord::Migration[7.0]
  def change
    rename_column :fechas, :bonita_c_id, :bonita
  end
end
