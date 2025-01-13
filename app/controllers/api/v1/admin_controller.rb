class Api::V1::AdminController < ApplicationController
  def change_password
    user = User.find_by(email: params[:email])

    if user
      user.password = params[:new_password]
      
      user.save.then do
        render json: { message: "Password changed successfully" }, status: :ok
      end.catch do |error|
        render json: { error: "Can't change password: #{error.message}" }, status: :unprocessable_entity
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end