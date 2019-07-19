class SessionsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sessions_mailer.magic_link.subject
  #
  def magic_link(user)
    @user       = user.decorate
    @magic_link = token_sign_in_url(user.login_token)
    @app_name   = Rails.application.config.app_name

    mail to: user.email,
      subject: default_i18n_subject(
        user: @user.to_label,
        app_name: @app_name
    )
  end
end
