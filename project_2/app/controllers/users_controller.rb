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
end
