class UsersController < ApplicationController

	def new
		@user = User.new  # a new blank user is created for form creation purposes
	end

	def create

		@user = User.new(user_params)  # a new user is created using the submitted parameters

		if @user.save  # if the new user saves, i.e. its information is valid
			@user.current_session = session[:session_id]
			@user.save
			redirect_to root_url, notice: "Thank you for signing up!"  # return to the root page
		else
			render "new"  # reload the Signup page with relevant errors
		end

	end

	private

		def user_params  # the parameters that can be submitted through forms
			params.require(:user).permit(:email, :password, :password_confirmation)  # new user forms can only fill out an email, a password, and a confirmation field
		end

end
