# Modelo Provision
class Provision < ApplicationRecord
    # Una provision pertenece a un proveedor
    belongs_to :provider
    # Una provision pertenece a un material
    belongs_to :material
  
    # Validar la presencia de los atributos obligatorios
    validates_presence_of :provider_id, :material_id, :price, :stock, :delivery_time
  
    # Validar que el precio sea un número positivo
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    # Validar que el stock sea un número entero no negativo
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
    # Validar que el tiempo de entrega sea un número entero positivo
    validates :delivery_time, numericality: { only_integer: true, greater_than: 0 }
end
  