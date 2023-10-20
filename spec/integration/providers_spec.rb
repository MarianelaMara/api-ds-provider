require 'swagger_helper'

RSpec.describe 'providers', type: :request do

  path '/providers' do

    get('list providers') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Lista todos los proveedores de materiales con los materiales que ofrecen '
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/providerList'
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

  path '/providers/filter' do
   
    get('filter provider') do
      parameter name: :Authorization, in: :header, type: :string
      security [{ BearerAuth: [] }]  #token de usuario
      produces 'application/json'
      consumes 'application/json'
      description 'Devuelve una lista de provedores que tienen disponible el stock suficiente del material en un precio menor o igual al ingresado y su estrega se estima antes de la fecha ingresada'
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/providerFilter' }
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/providerList'
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
