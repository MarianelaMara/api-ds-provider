class MakersController < ApplicationController

  def index
    @makers = Maker.all
    render_success({ Fabricantes: @makers.as_json}, {})
  end 

  def filter
      start_date = params[:start_date]
      end_date = params[:end_date]

      if start_date.present? && end_date.present? && Date.valid_date?(*start_date.split("-").map(&:to_i)) && Date.valid_date?(*end_date.split("-").map(&:to_i))
        @makers = Maker.available_between(start_date, end_date)
        render_success({ Markers: @makers.as_json}, {})      
      else
        render_error("Error", "las fechas no son validas ", BAD_REQUEST)
      end
    end
  end