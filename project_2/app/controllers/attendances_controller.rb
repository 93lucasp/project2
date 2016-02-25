class AttendancesController < ApplicationController
	def index
    	@user = User.find(params[:user_id])
   		@events = @user.events

  		render :index
  end
end
