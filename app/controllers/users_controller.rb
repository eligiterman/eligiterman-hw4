class UsersController < ApplicationController
  # Only logged-in users should be able to see places, and logged-in users should not be able to see other users' places
  # This piece of code was aided by ChatGPT
  has_many :places, dependent: :destroy
  
  def show
    @user = User.find_by({ "id" => params["id"] })
  end

  def new
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    # encrypt user's password before storing in database
    @user["password"] = BCrypt::Password.create(params["password"])
    @user.save
    redirect_to "/login"
  end
end
