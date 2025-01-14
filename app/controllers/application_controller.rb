class ApplicationController < ActionController::API
  before_action :authorize_request
  
  private
  
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    
    begin
      @decoded = JWT.decode(header, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      @current_user = User.find(@decoded[0]['sub'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end
end
