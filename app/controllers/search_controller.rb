class SearchController < ApplicationController

  before_filter :authenticate_user! # execute action in application controller to check for login

  # For when a show is added to a users collection
  def add

    # if the show doesn't already exist in the db, add and then create relation
    if Show.where(shid: params[:shID]).present? == false
      aShow = Show.new(shid: params[:shID], poster: params[:shPoster])
      aShow.save

      cUser = current_user
      cUser.shows << aShow
      cUser.save

    # if the show exists already in the db, check if it has a relation
    # with the user, and create the relation if not
    else
      aShow = Show.where(shid: params[:shID])[0]

      if current_user.show_ids.include?(aShow.id) == false
        cUser = current_user
        cUser.shows << aShow
        cUser.save
      end
    end

    if params[:shName].present? # when ajax request contains show name
      @showName = params[:shName]

      respond_to do |format|
        format.js { render action: "conf" } # execute conf.js.erb to render partial
      end

    else # clicking the add button
      respond_to do |format|
        format.js
      end
    end

  end

  # For when a user searches for a show
  def query

    # Allows us to execute javascript
    respond_to do |format|
      format.html
      format.js
    end

    # If a post request is made, store the show name in @query
    if request.post?
      @query = params[:show]
    end

  end
end
