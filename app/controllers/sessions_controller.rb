class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  def new
    @user = User.new
  end

  def create
    @email = params[:user][:email]
    @user  = User.find_or_initialize_by(email: @email)

    if @user.update(login_token: SecureRandom.urlsafe_base64,
                    login_token_valid_until: 30.minutes.from_now)
      SessionsMailer.magic_link(@user).deliver
    else
      render :new
    end
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
    redirect_to root_path, notice: t('flash.logged_out')
  end
end
