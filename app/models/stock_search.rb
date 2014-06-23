class StockSearch < ActiveRecord::Base
	include ActiveModel::Validations

	validates_date :start_date
	validates_date :end_date, after: :start_date

end
