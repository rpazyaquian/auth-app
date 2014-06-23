class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authorize
      redirect_to login_url, alert: "Please sign up or log in to complete this action." if current_user.nil?
    end

  	def current_user  # create an application-wide current_user variable
  		@current_user ||= User.find_by current_session: session[:session_id]  # current user already exists or is found based on the session id
  	end

  	# if @current_user already exists, then that value is used.
  	# if no user is found, current_user is considered nil.

  	helper_method :current_user, :authorize  # allows this to be used all over.

end
