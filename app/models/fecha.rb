class Fecha < ApplicationRecord


    validates_uniqueness_of :bonita
    validates :arreglo, presence: true
    before_save :ordenar_fechas

    def pop_smallest_date
        self.arreglo.sort_by! { |fecha| DateTime.parse(fecha) }
        self.arreglo.shift
    end
  
    private
  
    def ordenar_fechas
      self.arreglo = self.arreglo.sort_by { |fecha| DateTime.parse(fecha) } 
    end
end
  