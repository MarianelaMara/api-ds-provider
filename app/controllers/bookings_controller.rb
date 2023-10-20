class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    render_success({ Reservas: @bookings}, {})
  end 

  def show
    @bookings = Booking.find(params[:id])
    render_success({ Reserva: @bookings}, {})
  end 

  def create
    provider_type = params[:provider_type].capitalize
    provider_id = params[:provider_id]
    start_date = params[:start_date]
    end_date = params[:end_date]
    if  provider_type == "Maker"
      booking = Booking.new(provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date)
    elsif provider_type == "Provider"
      delivery_place = params[:delivery_place].downcase.strip
      material_name = params[:material].downcase
      material_id = Material.find_by(name: material_name)
      quantity = params[:quantity]
      booking = Booking.new(provider_type: provider_type, provider_id: provider_id, start_date: start_date, end_date: end_date, material:  material_id, quantity: quantity, delivery_place: delivery_place)
    end 
  
    if booking.save     
      render_success({ Reserva: booking}, {}, CREATED)
    else
      render_error("Error", booking.errors, INTERNAL_SERVER_ERROR)
    end
  end
  
  end
  