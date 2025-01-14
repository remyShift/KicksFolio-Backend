class Api::V1::PasswordsController < ApplicationController
  def forgot
    user = User.find_by(email: params[:email])
    
    if user
      reset_token = generate_reset_token
      user.update(
        reset_password_token: reset_token,
        reset_password_sent_at: Time.current
      )
      
      PasswordMailer.reset_password_email(user, reset_token).deliver_now
      
      render json: { message: "Instructions de réinitialisation envoyées à votre email" }, status: :ok
    else
      render json: { error: "Email non trouvé" }, status: :not_found
    end
  end

  def reset
    user = User.find_by(reset_password_token: params[:token])
    
    if user && token_valid?(user)
      if user.update(password: params[:password], reset_password_token: nil)
        render json: { message: "Mot de passe mis à jour avec succès" }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Token invalide ou expiré" }, status: :unprocessable_entity
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