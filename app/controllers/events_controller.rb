class EventsController < ApplicationController
  # before_action :swap_address_to_lat_long, only: :create

	def index
    	@user = User.find(params[:user_id])
    	@events = @user.events
	end

	def new
    	@event = Event.new
    	render :new
    end

  def create
      event_params = params.require(:event).permit(:game, :number_places, :user_id)
     #  lat_long = address_to_lat_long(event_params[:address])
      @event = Event.new(event_params)
     #  @event.lat = lat_long["lat"]
     #  @event.long = lat_long["long"]
     @event.user_id = current_user.id
        if @event.save
        redirect_to current_user # <-- go to show_user
      else
        #handle error
        render :new
      end

end
  
  def show
    @event = Event.find(params[:id])
    @allUsers = @event.users
    
  end
 
	

end
