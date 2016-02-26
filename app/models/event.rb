class Event < ActiveRecord::Base
	has_many :attendances
	has_many :users, through: :attendances
	belongs_to :user
end
