class SessionsController < ApplicationController

	def create
		user = User.find_by_email(params[:email])  # find a user with the supplied email

		if user && user.authenticate(params[:password])  # if a user with that email exists and the password matches
			user.current_session = session[:session_id]  # set that user's current session to the request's session id
			user.save
			redirect_to root_url, notice: "Welcome!"  # redirect to the new user page.
		else
			flash.now[:alert] = "Email or password is invalid."  # else, flash an error message.
			render "new"
		end

	end

	def destroy

		current_user.current_session = nil
		current_user.save
		redirect_to root_url, notice: "Logged out!"

	end

end
