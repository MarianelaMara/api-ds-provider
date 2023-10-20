# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  security_scheme_bearer = {
    type: :http,
    scheme: 'bearer',
    bearerFormat: 'JWT'
  }
  
  security_scheme_token = {
    type: :apiKey,
    name: 'token',
    in: :header
  }

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      "components": {
       " securitySchemes": {
          "BearerAuth": "security_scheme_bearer",
          "TokenAuth": "security_scheme_token"
        },
        "schemas": {      
          "StatusOk": {
            "type": "object",
            "properties": {
              "data": {"type": "string", "example": {} },
              "metadata": {"type": "string", "example": {} },
              "status": {"type": "integer", "example": 200 }
            }
          },
          "Status201": {
            "type": "object",
            "properties": {
              "data": {"type": "string", "example": {} },
              "metadata": {"type": "string", "example": {} },
              "status": {"type": "integer", "example": 201 }
            }
          },
          "Status401": {
            "type": "object",
            "properties": {
              "title": {"type": "string", "example": "invalid_token" },
                "detail": {"type": "string", "example": "" },
                "status": {"type": "integer", "example": 401 }
            }
          },
          "Status403": {
            "type": "object",
            "properties": {
              "title": {"type": "string", "example": "not_authorized" },
                "detail": {"type": "string", "example": "" },
                "status": {"type": "integer", "example": 403 }
            }
          },
          "Status404": {
            "type": "object",
            "properties": {
              "title": {"type": "string", "example": "record_not_found" },
                "detail": {"type": "string", "example": "" },
                "status": {"type": "integer", "example": 404 }
            }
          },
          "Status422": {
            "type": "object",
            "properties": {
              "title": {"type": "string", "example": "unprocessable entity" },
                "detail": {"type": "string", "example": "" },
                "status": {"type": "integer", "example": 422 }
            }
          },
          "Status500": {
            "type": "object",
            "properties": {
              "title": {"type": "string", "example": "internal server error" },
                "detail": {"type": "string", "example": "" },
                "status": {"type": "integer", "example": 500 }
            }
          },
          "bookingCreate": {
            "properties": {
              "id":{ "type": "integer", "example": 3 },
              "provider_type": { "type": "string", "example": "Maker"},
              "provider_id":{ "type": "integer", "example": 1},
              "start_date": { "type": "string", "example":  "2023-01-02"},
              "end_date": { "type": "string", "example":  "2023-01-25"},
              "price": { "type": "decimal", "example": 400000 },
              "quantity":{ "type": "integer", "description": 'Cantidad reservada en caso de ser de material',  "example": 30, "nullable": true },
              "material_id": { "type": "integer",  "description": 'id del material si es una reserva de material', "example": 3,  "nullable": true },
              "aasm_state": { "type": "string", "description": 'Estado de la reserva', "example": "pending"},
              "delivery_place":{ "type": "string", "description": 'Direccion a entregar la reserva en caso de ser de un material', "example": "Rua das Flores, 123", "nullable": true}
            }
          },
          "booking": {
            "type": "object",
            "properties": {
              "id":{ "type": "integer", "example": 3 },
              "provider_type": { "type": "string", "example": "Maker"},
              "provider_id":{ "type": "integer", "example": 1},
              "start_date": { "type": "string", "example":  "2023-01-02"},
              "end_date": { "type": "string", "example":  "2023-01-25"},
              "price": { "type": "decimal", "example": 400000 },
              "quantity":{ "type": "integer", "description": 'Cantidad reservada en caso de ser de material',  "example": 30, "nullable": true },
              "material_id": { "type": "integer",  "description": 'id del material si es una reserva de material', "example": 3,  "nullable": true },
              "aasm_state": { "type": "string", "description": 'Estado de la reserva', "example": "pending"},
              "delivery_place":{ "type": "string", "description": 'Direccion a entregar la reserva en caso de ser de un material', "example": "Rua das Flores, 123", "nullable": true}
            }
          },
          "bookingShow": {
            "type": "object",
            "properties": {
              "data": { 
                  "type": "object", 
                  "description": "Los datos de la respuesta", 
                  "properties": { 
                    "reserva": { '$ref' => '#/components/schemas/booking' }  
                  } 
              },
              "metadata": { 
                "type": "object", 
                "description": "Los metadatos de la respuesta",
              },
              "status": { 
                "type": "string",
                "description": "El código de estado de la respuesta",
                "example": "200"
              } 
            }
          },
          "bookingList": {
            "type": "object",
            "properties": {
              "data": { 
                "type": "object", 
                "description": "Los datos de la respuesta", 
                "properties": { 
                  "Reservas": { 
                    "type": "array", 
                    "description": "Una lista de reservas", 
                    "items": { '$ref' => '#/components/schemas/booking' } 
                  } 
                } 
              },
                "metadata": { "type": "object", "description": "Los metadatos de la respuesta" },
                "status": { "type": "string", "description": "El código de estado de la respuesta" } 
              }
          },
          "provision": {
            "type": "object",
            "properties": {
              "id":{ "type": "integer", "example": 3 },
              "provider_id":{ "type": "integer", "example": 1},
              "price": { "type": "decimal", "example": 400000 },
              "stock":{ "type": "integer", "example": 50 },
              "delivery_time":{ "type": "integer", "example": 20 },
              "material": {
                "type": "object",
                "properties": {
                "name": { "type": "string", "example": "Maker"},
                }
              }
            }
          },
          "provider": {
            "type": "object",
            "properties": {
              "id":{ "type": "integer", "example": 3 },
              "name": { "type": "string", "example": "Maderas S.A."}, 
              "country": { "type": "string", "example": "Argentina"}, 
              "address": { "type": "string", "example":  "Av. San Martín 1234"}, 
              "city": { "type": "string", "example":  "City Bell"},
              "provisions": { 
                "type": "array", 
                "description": "Una lista de provedores y los materiales que ofrecen", 
                "items": { '$ref' => '#/components/schemas/provision' } 
              } 
            }
          },
          "providerList": {
            "type": "object",
            "properties": {
              "data": { 
                "type": "object", 
                "description": "Los datos de la respuesta", 
                "properties": { 
                  "Provedores ": { 
                    "type": "array", 
                    "description": "Una lista de provedores y los materiales que ofrecen", 
                    "items": { '$ref' => '#/components/schemas/provider' } 
                  } 
                } 
              },
                "metadata": { "type": "object", "description": "Los metadatos de la respuesta" },
                "status": { "type": "string", "description": "El código de estado de la respuesta" } 
            }
          },
          "providerFilter": {
            "properties": {
              "material": { "type": "string", "example": "pino"},
              "stock":{ "type": "integer", "example": 400},
              "price": { "type": "decimal", "example": 400 },
              "date": { "type": "string", "example":  "2023-01-02"}
            }
          },
          "makerFilter": {
            "properties": {
              "start_date": { "type": "string", "example":  "2023-01-02"},
              "end_date": { "type": "string", "example":  "2023-01-30"}
            }
          },
          "maker": {
            "type": "object",
            "properties": {
              "id":{ "type": "integer", "example": 3 },
              "name": { "type": "string", "example": "Maderas S.A."}, 
              "country": { "type": "string", "example": "Argentina"}, 
              "address": { "type": "string", "example":  "Av. San Martín 1234"}, 
              "city": { "type": "string", "example":  "City Bell"},
              "price": { "type": "decimal", "example": 4000 },
            }
          },
          "makerList": {
            "type": "object",
            "properties": {
              "data": { 
                "type": "object", 
                "description": "Los datos de la respuesta", 
                "properties": { 
                  "makers": { 
                    "type": "array", 
                    "description": "Una lista de provedores de fabricacion ", 
                    "items": { '$ref' => '#/components/schemas/maker' } 
                  } 
                } 
              },
                "metadata": { "type": "object", "description": "Los metadatos de la respuesta" },
                "status": { "type": "string", "description": "El código de estado de la respuesta" } 
            }
          },
          "login": {
            "properties": {
              "email": { "type": "string", "example": "example@email.com"},
              "password":{ "type": "string", "example": "123456"}
            }
          },
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://providers.com',
          variables: {
            defaultHost: {
              default: 'localhost'
            }
          }
        }
      ]
    }
  }

   # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end