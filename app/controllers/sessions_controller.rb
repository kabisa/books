class SessionsController < ApplicationController
  def create
    @email = params[:email]
    user = User.find_or_create_by!(email: @email)
    user.update!(login_token: SecureRandom.urlsafe_base64,
                 login_token_valid_until: 30.minutes.from_now)

    SessionsMailer.magic_link(user).deliver
  end

  def show
    user = User.valid_with_token(params[:token])

    if user
      user.invalidate_token

      self.current_user = user
      redirect_to root_path
    #else
      #redirect_to root_path, alert: 'Invalid or expired login link'
    end
  end

  def destroy
    self.current_user = NullUser.new
    redirect_to root_path
  end
end
