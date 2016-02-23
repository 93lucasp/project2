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
    user_params = params.require(:user).permit(:first_name, :last_name, :address, :city, :email, :password)
    @user = User.create(user_params)
    login(@user) # <-- login the user
    redirect_to "/users/#{@user.id}" # <-- go to show
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def address_to_lat_long(address)
    res = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + address, verify: false).parsed_response
    res["results"][0]["geometry"]["location"]
  end
  
end
