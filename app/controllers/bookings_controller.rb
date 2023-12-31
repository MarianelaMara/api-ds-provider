class BookingsController < ApplicationController
  require 'date' # requiere la librería de Date
  def index
    @bookings = Booking.all
    render_success({ Reservas: @bookings}, {})
  end 

  def show
    @bookings = Booking.find(params[:id])
    render_success({ Reserva: @bookings}, {})
  end 
  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      render_success()
    else
      render_error("Error", @booking.errors, INTERNAL_SERVER_ERROR)
    end
  end 

  def create_booking_maker
 
    provider_type = params[:provider_type].capitalize
    provider_id = params[:provider_id]
    case_id = params[:case_id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    booking = Booking.new(provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date)
    if booking.save     
      render_success({ Reserva: booking}, {}, CREATED)
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end 
  end   

  def create_booking_material    
    @status = true
    @materials = params[:materials]
    @array = [] # crea un array vacío
    @materials.each do |m|  
      provider_type = m[:provider_type].capitalize
      provider_id = m[:provider_id]
      case_id = m[:case_id]
      start_date = m[:start_date]
      end_date = m[:end_date]
      delivery_place = m[:delivery_place].downcase.strip
      material_name = m[:material].downcase
      material_id = Material.find_by(name: material_name)
      quantity = m[:quantity]
      delivery_time = m[:delivery_time]
      booking = Booking.new(delivery_time: delivery_time, case_id: case_id, provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date, material: material_id, quantity: quantity, delivery_place: delivery_place)   
      @status = false  unless booking.save
    end   
    case_id = @materials.first[:case_id]
    end_dates = @materials.map { |m| m[:end_date] }
    fecha = Fecha.new(bonita: case_id, arreglo: end_dates)
    fecha.save
    if @status    
      render json: fecha, status: CREATED
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end
  end
  def add_booking_material  
    @material =  params[:materials].first
    provider_type =  @material[:provider_type].capitalize
    provider_id = @material[:provider_id]
    case_id = @material[:case_id]
    start_date = @material[:start_date]
    end_date = @material[:end_date]
    delivery_place = @material[:delivery_place].downcase.strip
    material_name = @material[:material].downcase
    material_id = Material.find_by(name: material_name)
    quantity = @material[:quantity]
    delivery_time = @material[:delivery_time]
    booking = Booking.new(delivery_time: delivery_time, case_id: case_id, provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date, material: material_id, quantity: quantity, delivery_place: delivery_place)   
    case_id =  @material[:case_id]
    @fecha = Fecha.find_by(bonita: case_id )
    @fecha.arreglo <<  @material[:end_date]     
    @fecha.save

    if booking.save  
      render json: @fecha, status: CREATED
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end
  end


  def state
    @booking = Booking.find(params[:id])
    res = @booking.aasm_state
    render json: res, status: OK
  end 
  def get_first_booking 
    @booking = Booking.where(case_id: params[:case_id], provider_type: "Provider").order(:end_date).first 
    if @booking 
      render json: @booking, status: OK 
    else 
      render json: { message: "No hay más reservas para este caso" }, status: 404 
    end 
  end

  def delete_all
   if Booking.destroy_all
    render json: "se eliminaron todas las reservas ", status: OK 
    else 
      render json: { message: "No se pudieron eliminar todas las reservas " }, status: 404 
    end 
  end 

  def delete
    @p = Provision.all
    @p.each do |p|
     p.destroy
    end
  end

 def channge_state
  @booking = Booking.find(params[:id])
  state = params[:state]
  if state == "finish" 
    @booking.finish
  elsif state == "cancel"
    @booking.cancel
 end 
 render json: @booking, status: OK 
end 

def delayed
  @booking = Booking.find(params[:id])
  @booking.end_date = params[:new_date]
  @booking.delay
  @booking.save
  @fechas = Fecha.find_by(bonita: @booking.case_id)
  @fechas.arreglo << params[:new_date] 
  if @fechas.save
    render json: "se modifico la fecha de la reserva", status: OK 
  else 
    render json: { message: "No se pudo modificar la fecha de la reserva " }, status: 404 
  end 
end 
  
end
  