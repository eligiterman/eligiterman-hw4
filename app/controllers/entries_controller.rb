class EntriesController < ApplicationController

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = session["user_id"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash["notice"] = "You must log in to add a journal entry."
      redirect_to "/login"
    end
  end

end
