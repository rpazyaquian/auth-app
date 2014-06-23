class User < ActiveRecord::Base
	has_many :job_apps

	has_secure_password

	validates_uniqueness_of :email
end
