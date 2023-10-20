require 'swagger_helper'

RSpec.describe 'bookings', type: :request do

  path '/bookings' do

    get('list bookings') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Lista todas las reservas del sistema'
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/bookingList'
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end
      response '401', 'invalid_token' do
        schema '$ref' => '#/components/schemas/Status401'
        run_test!
      end
        response '403', 'not_authorized' do   
        schema '$ref' => '#/components/schemas/Status403'
        run_test!       
      end 
      response '422', 'unprocessable entity' do           
        schema '$ref' => '#/components/schemas/Status422'
        run_test!    
      end 
      response '500', 'internal server error' do       
        schema '$ref' => '#/components/schemas/Status500'
        run_test!   
      end  
    end

    post('create booking') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  
      produces 'application/json'
      consumes 'application/json'
      description 'Crea una reserva que puede ser de un material o de un espacio de fabricación, en caso de ser una reserva de material se chequea que el stock sea suficiente y en caso de ser de lugar de fabricación se chequea que las fechas esten disponibles. No todos  los parametros son obligatorios ya que dependen del tipo de reserva '
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/bookingCreate' }
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/Status201'
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end
      response '401', 'invalid_token' do
        schema '$ref' => '#/components/schemas/Status401'
        run_test!
      end
        response '403', 'not_authorized' do   
        schema '$ref' => '#/components/schemas/Status403'
        run_test!       
      end 
      response '404', 'record_not_found' do     
        schema '$ref' => '#/components/schemas/Status404'
       run_test!          
      end 
      response '422', 'unprocessable entity' do           
        schema '$ref' => '#/components/schemas/Status422'
        run_test!    
      end 
      response '500', 'internal server error' do       
        schema '$ref' => '#/components/schemas/Status500'
        run_test!   
      end  
    end
  end

  path '/bookings/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show booking') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Permite ver los datos de una reserva'
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/bookingShow'
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end
      response '401', 'invalid_token' do
        schema '$ref' => '#/components/schemas/Status401'
        run_test!
      end
        response '403', 'not_authorized' do   
        schema '$ref' => '#/components/schemas/Status403'
        run_test!       
      end 
      response '404', 'record_not_found' do     
        schema '$ref' => '#/components/schemas/Status404'
       run_test!          
      end 
      response '422', 'unprocessable entity' do           
        schema '$ref' => '#/components/schemas/Status422'
        run_test!    
      end 
      response '500', 'internal server error' do       
        schema '$ref' => '#/components/schemas/Status500'
        run_test!   
      end  
    end
  end
end
