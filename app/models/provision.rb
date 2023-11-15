# Modelo Provision
class Provision < ApplicationRecord
    belongs_to :provider
    belongs_to :material
    
    validates :material_id, uniqueness: { scope: :provider_id, message: "Este material ya es provisto por este proveedor" } 
  
    validates_presence_of :provider_id, :material_id, :price, :stock, :delivery_time
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :delivery_time, numericality: { only_integer: true, greater_than: 0 }
end
  