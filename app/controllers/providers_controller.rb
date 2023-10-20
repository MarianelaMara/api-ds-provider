class ProvidersController < ApplicationController

    def index
        @providers = Provider.all
        render_success({ provedores: @providers.as_json}, {})
    end 

    def filter
      material = params[:material].downcase
      material_id = Material.find_by(name: material).id
      stock = params[:stock].to_i
      price = params[:price].to_f
      date = params[:date].to_date
      # Filtrar los proveedores que tengan el material con el precio menor o igual al dado y con el tiempo de entrega menor o igual a la diferencia entre la fecha dada y la actual
      @providers = Provider.includes(:provisions).joins(:provisions).where("provisions.material_id = ? AND provisions.price <= ? AND provisions.delivery_time <= ? AND provisions.stock >= ?", material_id, price, (date - Date.today).to_i, stock)
    
      # Renderizar la respuesta en formato JSON
      render_success({ provedores: @providers.as_json}, {})
    end


end