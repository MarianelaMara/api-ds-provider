require 'swagger_helper'

RSpec.describe 'makers', type: :request do

  path '/makers/filter' do

    get('filter maker') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Devuelve una lista de provedores de lugares de fabricacion  que tienen disponible las fechas del rando que se paso como parametro '
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/makerFilter' }
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/makerList'
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

  path '/makers' do

    get('list makers') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Lista todos los lugares de fabricacion del sistema'
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/makerList'
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

   
  end

 
end
