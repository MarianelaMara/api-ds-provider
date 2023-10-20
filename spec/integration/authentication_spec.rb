require 'swagger_helper'

RSpec.describe 'authentication', type: :request do

  path '/auth/login' do

    post('login authentication') do
      produces 'application/json'
      consumes 'application/json'
      description 'Devuelve un token de autenticación en el header Authorization'
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/login' }
      response '200', 'successful' do
        schema '$ref' => '#/components/schemas/StatusOk'
        let(:Authorization) { "Bearer #{token}" }
        run_test!
        header 'Authorization', type: :string, description: 'Token de usuario'
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
