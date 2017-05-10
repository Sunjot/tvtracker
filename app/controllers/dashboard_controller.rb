class DashboardController < ApplicationController

  before_filter :authenticate_user!

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
