class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    render_success({ Reservas: @bookings}, {})
  end 

  def show
    @bookings = Booking.find(params[:id])
    render_success({ Reserva: @bookings}, {})
  end 

  def create_booking_material
    provider_type = params[:provider_type].capitalize
    provider_id = params[:provider_id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    booking = Booking.new(provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date)
    if booking.save     
      render_success({ Reserva: booking}, {}, CREATED)
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end 
  end   

  def create_booking_maker
    @status = true
    @materials = params[:materials]
    @materials.each do |m|  
      provider_type = m[:provider_type].capitalize
      provider_id = m[:provider_id]
      start_date = m[:start_date]
      end_date = m[:end_date]
      delivery_place = m[:delivery_place].downcase.strip
      material_name = m[:material].downcase
      material_id = Material.find_by(name: material_name)
      quantity = m[:quantity]
      booking = Booking.new(provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date, material: material_id, quantity: quantity, delivery_place: delivery_place)   
      @status = false  unless booking.save
    end   
    if @status      
      render_success({}, {}, CREATED)
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end
  end 
  
   

  def delete
    @p = Provisions.all
    @p.each do |p|
     p.destroy
    end
 end
  
  end
  