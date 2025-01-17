class Api::V1::PasswordsController < ApplicationController
  skip_before_action :authorize_request, only: [:forgot, :reset]
  
  def forgot
    user = User.find_by(email: params[:email])
    
    if user
      reset_token = generate_reset_token
      user.update(
        reset_password_token: reset_token,
        reset_password_sent_at: Time.current
      )
      
      PasswordMailer.reset_password_email(user, reset_token).deliver_now
      
      render json: { message: "Reset password instructions sent to your email" }, status: :ok
    else
      render json: { error: "Email not found" }, status: :not_found
    end
  end

  def reset
    user = User.find_by(reset_password_token: params[:token])
    
    if user && token_valid?(user)
      if user.update(password: params[:password], reset_password_token: nil)
        render json: { message: "Password updated successfully" }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid or expired token" }, status: :unprocessable_entity
    end
  end

  private

  def generate_reset_token
    SecureRandom.urlsafe_base64(32)
  end

  def token_valid?(user)
    user.reset_password_sent_at && user.reset_password_sent_at > 1.hour.ago
  end
end