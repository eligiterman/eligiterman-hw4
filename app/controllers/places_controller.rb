class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil    
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"] , "user_id" => @user["id"] })
    else
      flash["notice"] = "Please login to see your journal entries."
      redirect_to "/login"
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil    
      @place = Place.new
    else
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil    
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
    else
      flash["notice"] = "Please login first."
    end
    redirect_to "/places"
  end

end
