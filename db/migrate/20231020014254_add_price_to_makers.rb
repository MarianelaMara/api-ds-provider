class AddPriceToMakers < ActiveRecord::Migration[7.0]
  def change
    add_column :makers, :price, :decimal
  end
end
