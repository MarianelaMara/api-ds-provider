class MarkersController < ApplicationController
    # Acción para manejar las peticiones al endpoint de los makers
    def filter
      # Obtener las fechas del query string
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      start_year = start_date.year
      end_year = end_date.year
      dates = []

      # Recorrer el rango de fechas y aplicar la función to_date a cada elemento
    (start_date..end_date).each do |date|
      dates << date
    end

      # Validar que las fechas estén presentes y sean válidas
      if start_date.present? && end_date.present?
        # Obtener los makers disponibles entre las fechas
        @makers = Maker.joins(:calendars).where("calendars.year BETWEEN ? AND ?", start_year, end_year).where("calendars.free_dates <@ ARRAY[?]::date[]", dates).distinct
        render_success({ Markers: @makers}, {})
      
      else
        render json: { error: "Invalid or missing dates" }, status: BAD_REQUEST
      end
    end
  end