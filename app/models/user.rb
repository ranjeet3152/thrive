class User < ApplicationRecord
	has_many :transactions
	validates_uniqueness_of :mobile
	validates_presence_of :mobile
end
