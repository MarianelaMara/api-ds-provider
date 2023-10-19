# Modelo Calendar
class Calendar < ApplicationRecord
    # Un calendario pertenece a un proveedor
    belongs_to :maker
  
    # Validar la presencia de los atributos obligatorios
    validates_presence_of :maker_id, :year
  
    # Validar que el año sea un número entero positivo
    validates :year, numericality: { only_integer: true, greater_than: 0 }
  

  end
  