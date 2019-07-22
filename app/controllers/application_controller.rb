class ApplicationController < ActionController::Base
  before_action :make_action_mailer_use_request_host_and_protocol

  helper_method :current_user

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id])&.decorate || NullUser.new
  end

  private

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
