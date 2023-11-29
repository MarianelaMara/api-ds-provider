class Fecha < ApplicationRecord

    validates :arreglo, presence: true
    before_save :ordenar_fechas

    def pop_smallest_date
        self.arreglo.sort_by! { |fecha| Date.parse(fecha) }
        self.arreglo.shift
    end
  
    private
  
    def ordenar_fechas
      self.arreglo = self.arreglo.sort_by { |fecha| Date.parse(fecha) }
    end
end
  