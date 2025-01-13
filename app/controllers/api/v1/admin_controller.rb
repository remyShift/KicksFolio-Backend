class Api::V1::AdminController < ApplicationController
  def change_password
    user = User.find_by(email: params[:email])

    if user
      if user.update(password: params[:new_password])
        render json: { message: "Password changed successfully" }, status: :ok
      else
        render json: { error: "Can't change password: #{user.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end