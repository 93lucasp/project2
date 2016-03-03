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
    @coords = address_to_lat_long(userAddressFull)
    @user.update(:lat => @coords["lat"], :lng => @coords["lng"])
    login(@user) # <-- login the user
    redirect_to "/users/#{@user.id}" # <-- go to show
  end

  def show
    @user = User.find(params[:id])


    # @adress= User.find(params[:id]).address

    # grab all the hosts
    # @hosts = User.where(true_or_false: true)
    @events = Event.where.not(user_id: nil)

    @lats = user_lats
    @lngs = user_lngs
		#FIXME: I'd write more comments explaining this. I'm not sure what it's doing.
    @lats.count.times do |count|
      if @lats[count] == nil
        @lats[count] = @user.lat
      end
    end
    @lngs.count.times do |count|
      if @lngs[count] == nil
        @lngs[count] = @user.lng
      end
    end


    # hosts = User.where(true_or_false: true)
    # @host_addresses = hosts.map do |host|
    #   address_to_lat_long(host.address)
    # end

    # @events=Event.all
    render :show
  end

  private

  def user_lats
    lats = @events.map do |e|
      e.user.lat
    end
  end

  def user_lngs
    lngs = @events.map do |e|
      e.user.lng
    end
  end

  def address_to_lat_long(address)
      # @event.lat = lat_long["lat"]
      # @event.long = lat_long["long"]
      res = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + address, verify: false).parsed_response
      res["results"][0]["geometry"]["location"]
  end

end
