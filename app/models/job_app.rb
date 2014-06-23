class JobApp < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :title
	validates_presence_of :description
	validates_presence_of :company
	validates_presence_of :date

end
