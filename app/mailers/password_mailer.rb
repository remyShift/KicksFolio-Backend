class PasswordMailer < ApplicationMailer
  def reset_password_email(user, reset_token)
    @user = user
    @reset_token = reset_token
    mail(
      to: @user.email,
      subject: "Instructions de réinitialisation de mot de passe"
    )
  end
end