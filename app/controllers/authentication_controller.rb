class AuthenticationController < ApplicationController

    skip_before_action :authenticate_request, only: [:login]

    #POST /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            response.set_header('Authorization', token) # Establece el token en la cabecera
            render_success({ message: "Login exitoso"}, {})
        else
            render_error("Error", "Usuario o clave invalido", INTERNAL_SERVER_ERROR)
        end
    end
end