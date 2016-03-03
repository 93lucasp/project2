class AttendancesController < ApplicationController
	def index
    	@user = User.find(params[:user_id])
   		@events = @user.events

  		render :index
  	end

	#FIXME: this should be `create`
	def joinEvent
			#TODO: nice job authorizing the user can only create an event for themselves
  		@user = current_user
  		@event = Event.find(params[:event_id])
  		@user.events.push(@event)
  		redirect_to  "/events/:event_id"

	end

end
