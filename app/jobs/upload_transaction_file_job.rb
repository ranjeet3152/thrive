class UploadTransactionFileJob < ActiveJob::Base
	require 'csv'
	queue_as :default

	def perform(*args)
		transactions = array_of_records(args[0])
	  Transaction.import transactions
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
	    user_id: record[1],
	    amount_spent: record[2],
	    merchant_id: record[3],
	    bill_number: record[4],
	    payment_type: record[5]
	  }
	end

end