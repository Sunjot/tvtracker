class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def info
  end

  def remove

    if params[:shID].present?
      remove_show = Show.where(shid: params[:shID])[0] # get the show with matching show id
      current_user.shows.destroy(remove_show) # remove that show association from current user
    end

  end

  def display

    @showCount = current_user.show_ids.count
    @index = current_user.show_ids

    @showInfo = []
    @index.each do |i|
      unless Show.select(:shid).find(i).shid.nil?
        @showInfo << Show.select("shid, poster").find(i)
      end
    end

    respond_to do |format|
      format.html
    end

  end

end
