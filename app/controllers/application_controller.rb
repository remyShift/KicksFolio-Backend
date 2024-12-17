class ApplicationController < ActionController::API

  private

  def authorize_request
    header = request.headers["Authorization"]
    return unauthorized_error("No token provided") if header.nil?
  
    begin
      token = header.split(" ").last

      return unauthorized_error("Token invalidated") if InvalidToken.valid.exists?(token: token)

      decoded = JWT.decode(token, ENV["JWT_SECRET"], true, algorithm: "HS256")
      @current_user = User.find(decoded[0]["sub"])
    rescue JWT::ExpiredSignature
      unauthorized_error("Token has expired")
    rescue JWT::DecodeError
      unauthorized_error("Invalid token")
    rescue ActiveRecord::RecordNotFound
      unauthorized_error("User not found")
    end
  end

  def unauthorized_error(message)
    render json: { error: message }, status: :unauthorized
  end
end
