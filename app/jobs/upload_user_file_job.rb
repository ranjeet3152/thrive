class UploadUserFileJob < ActiveJob::Base
	require 'csv'
	queue_as :default

	def perform(*args)
		users = array_of_records(args[0])
	  User.import users
	  @admin = Admin.last
	  total_records = users.size 
	  AdminMailer.welcome_email(@admin, total_records).deliver_now
	end

	def array_of_records(file_path)
	  records = []
	  CSV.read(file_path).each do |record|
	    records << extract_(record)
	  end
	  records
	end

	def extract_(record)
	  {
	    name: record[1],
	    mobile: record[2]
	  }
	end

end