class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil    
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"] })
    else
      flash["notice"] = "Login to see places and journal entries."
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil    
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
    else
      flash["notice"] = "Must login first."
    end
    redirect_to "/places"
  end

end
