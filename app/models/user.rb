class User < ActiveRecord::Base
	has_secure_password
	has_one :event
	has_many :attendances
	has_many :events, through: :attendances
	


	def self.confirm(params)
    	@user = User.find_by({email: params[:email]})
    	@user.try(:authenticate, params[:password])
 	end
end
