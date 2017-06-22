class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def info

      respond_to do |format|
        format.js
      end

  end

  def remove

    if params[:shID].present?
      remove_show = Show.where(shid: params[:shID])[0] # get the show with matching show id
      current_user.shows.destroy(remove_show) # remove that show association from current user

    else
      respond_to do |format|
        format.js
      end
    end

  end

  def display

    @showCount = current_user.show_ids.count
    @index = current_user.show_ids

    @showIDs = []
    @index.each do |i|
      if Show.select(:shid).find(i).present?
        @showIDs << Show.select(:shid).find(i)
      end
    end

    respond_to do |format|
      format.html
    end

  end

end
