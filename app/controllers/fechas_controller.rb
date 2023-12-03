class FechasController < ApplicationController

    def index 
        @fechas = Fecha.all
        render_success({fechas:@fechas}, {}, OK)
    end 

    def delete_all
       if  Fecha.destroy_all
        render_success({}, {}, OK)
       end 
    end 

    def create
        @fecha = Fecha.new(fecha_params)
        if @fecha.save
            render_success({}, {}, CREATED)
        else
            render_error("Error", @fecha.errors, INTERNAL_SERVER_ERROR)
        end
    end
  
   def smallest_date 
    @fecha = Fecha.find_by(bonita: params[:case_id]) 
    @smallest_date = @fecha.arreglo.first # solo devuelve la primera fecha sin eliminarla 
    if @smallest_date # verifica si hay una fecha válida 
        @fecha.arreglo.delete_at(0) # elimina la primera fecha del arreglo 
        @fecha.save # guarda el cambio en el arreglo 
        render json: @smallest_date, status: OK 
    else # si no hay una fecha válida 
        render json: "no hay más fechas", status: NOT_FOUND 
    end 
end

    private
  
    def fecha_params
      params.require(:fecha).permit(:bonita, arreglo: [])
    end
  end
  