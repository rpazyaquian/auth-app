class JobAppsController < ApplicationController

	# note that all job apps must be the property of the user in order to be viewed
	# make sure that authorization works properly!

	# since everything here relies on a user being logged in, everything(?) related to job apps
	# requires the user to be authenticated/authorized. 

	before_filter :authorize

	def index
		# list all job applications that a user has made
		@list = current_user.job_apps
	end	

	def show
		# show the details of a specific job app
		if JobApp.find(params[:id]).user == current_user
			@app = JobApp.find(params[:id])
		else
			redirect_to apptracker_url, alert: "You are not authorized to view this application."
		end
	end

	def new
		# show a form for creating a new job app
		@job = JobApp.new
	end

	def create
		# handle the logic for creating a new job app
		@job = current_user.job_apps.new(app_params)

		if @job.save
			redirect_to apptracker_url, notice: "New job application recorded."
		else
			render "new"
		end
	end

	def destroy
		# delete a job app
	end

	private

		def app_params
			params.require(:job_app).permit(:title, :description, :company, :submission_date)
		end

end
