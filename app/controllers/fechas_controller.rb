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
        @smallest_date = @fecha.pop_smallest_date
        @fecha.save
        if !@smallest_date.nil?
            render json: @smallest_date, status: OK
        else
            render json: "no hay mas fechas", status: NOT_FOUND
        end
    end

    private
  
    def fecha_params
      params.require(:fecha).permit(:bonita, arreglo: [])
    end
  end
  