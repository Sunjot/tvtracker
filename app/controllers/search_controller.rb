class SearchController < ApplicationController

  before_filter :authenticate_user! # execute action in application controller to check for login

  def query

    # Allows us to execute javascript from the query.js.erb file
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
