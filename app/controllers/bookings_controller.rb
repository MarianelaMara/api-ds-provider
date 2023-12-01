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
      booking = Booking.new(case_id: case_id, provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date, material: material_id, quantity: quantity, delivery_place: delivery_place)   
      @status = false  unless booking.save
      @hash = {} # crea un hash vacío
      @hash["booking_id"] = booking.id
      @hash["date"] = end_date
      @array.push(@hash) # agrega el hash al array
    end   
    if @status   
      @array.sort_by! { |h| Date.parse(h["date"]) } # ordena el array por fecha   
      render json: @array, status: CREATED
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
    @booking = Booking.where(case_id: params[:id]).order(:end_date).first 
    if @booking 
      render json: @booking, status: OK 
    else 
      render json: { message: "No hay más reservas para este caso" }, status: 404 
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
  elsif state == "delay"
    @booking.delayed
  elsif state == "cancel"
    @booking.cancel
 end 
 render json: @booking, status: OK 
end 
  
end
  