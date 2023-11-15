class ProvidersController < ApplicationController

    def index
        @providers = Provider.all
        render_success({ provedores: @providers.as_json}, {})
    end 

    def filter
      materials = params[:materials]
      providers_hash = {}
      materials.each do |product|
        material = product[:material].downcase
        material_id = Material.find_by(name: material).id
        stock = product[:stock].to_i
        price = product[:price].to_f
        date = product[:date].to_date
        providers = Provider.includes(:provisions).joins(:provisions).where("provisions.material_id = ? AND provisions.price <= ? AND provisions.delivery_time <= ? AND provisions.stock >= ?", material_id, price, (date - Date.today).to_i, stock)
    
        providers.each do |provider|
          providers_hash[provider.id] = provider
        end
      end
    
      @providers = []
      providers_hash.each do |id, provider|
        @providers << provider unless @providers.include?(provider)
      end
      
      render_success({ provedores: @providers.as_json}, {})
    end

end