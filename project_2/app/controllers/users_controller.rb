class UsersController < ApplicationController
	def index
    @users = User.all
		render :index		
	end
	def new
    # we need to make
    # a new user
    # to pass to the 
    # form later
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :address, :city, :email, :password, :true_or_false, :lat, :lng)
    @user = User.create(user_params)
    userAddressFull = @user.address+" , "+@user.city
    @coords=address_to_lat_long(userAddressFull)
    @user.update(:lat => @coords["lat"], :lng => @coords["lng"])
    login(@user) # <-- login the user
    redirect_to "/users/#{@user.id}" # <-- go to show
  end

  def show
    @user = User.find(params[:id])
    @users= User.all
    # @adress= User.find(params[:id]).address
    userAddressFull = @user.address+" , "+@user.city
    @coords=address_to_lat_long(userAddressFull)

    
    # hosts = User.where(true_or_false: true)
    # @host_addresses = hosts.map do |host|
    #   address_to_lat_long(host.address)
    # end

    # @events=Event.all
    render :show
  end

  private

  def address_to_lat_long(address)    
      # @event.lat = lat_long["lat"]
      # @event.long = lat_long["long"]
      res = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + address, verify: false).parsed_response
      res["results"][0]["geometry"]["location"]
  end

end
