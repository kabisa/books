class ApplicationController < ActionController::Base
  include Pundit
  include Searchable

  protect_from_forgery with: :exception
  before_action :make_action_mailer_use_request_host_and_protocol
  after_action :verify_authorized, except: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id])&.decorate || NullUser.new
  end

  private

  def user_not_authorized
    flash[:warning] = t('flash.not_authorized')
    redirect_to(request.referrer || root_path)
  end

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
