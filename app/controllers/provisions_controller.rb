class ProvisionsController < ApplicationController

    def index
        @provisions = Provision.all
        render_success({ provisions: @provisions},{})
    end 

    def create
        # Busca una instancia de Provision que tenga los mismos valores de provider_id y material_id que los pasados como parámetros
        @provision = Provision.find_by(provider_id: provision_params[:provider_id], material_id: provision_params[:material_id])
        # Si no existe tal instancia, crea una nueva con los parámetros permitidos
        if  @provision.present?
            render_success({ provision_id: @provision.id }, "este material ya es provisto por este provedor debes editarlo id: #{@provision.id}")
            return
        else
            @provision = Provision.new(provision_params)
        end
        # Si la instancia se guarda correctamente, devuelve un mensaje de éxito y el id de la provisión
        if @provision.save
          render_success({ provision_id: @provision.id }, "Provisión creada con éxito")
        else
          # Si hay algún error, devuelve un mensaje de error y los errores de validación
          render_error(@provision.errors.full_messages, "No se pudo crear o encontrar la provisión")
        end
    end
      
  
  def destroy
    @provision = Provision.find(params[:id])
    if @provision.destroy
      render_success({}, "Provisión eliminada con éxito")
    else
      render_error(@provision.errors.full_messages, "No se pudo eliminar la provisión")
    end
  end
  
  def update
    @provision = Provision.find(params[:id])
    if @provision.update(provision_params_update)
      render_success({ provision: @provision }, "Provisión actualizada con éxito")
    else
      render_error(@provision.errors.full_messages, "No se pudo actualizar la provisión")
    end
  end
  
  private
  def provision_params
    params.require(:provision).permit(:provider_id, :material_id, :price, :stock, :delivery_time)
  end
  def provision_params_update
    params.require(:provision).permit(:price, :stock, :delivery_time)
  end
  

 
end