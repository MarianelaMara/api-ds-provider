class ApplicationController < ActionController::API
   
    include JsonWebToken
    include StatusCodes
    
    before_action :authenticate_request
    
    private

  def render_success(data = {}, metadata = {}, status = OK)
    render json: {
      "data": data,
      "metadata": metadata,
      "status": status
    }, status: status 
  end

  def render_error(title, detail, status = UNPROCESSABLE_ENTITY)
    render json: {
      "title": title, 
      "detail": detail, 
      "status": status 
    }, status: status 
  end  
    
    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = jwt_decode(header)
        if decoded == "Token not found"
            render json: { error: 'Not authenticated' }, status: :unauthorized
        else
            @current_user = User.find(decoded[:user_id])
        end
    end
end