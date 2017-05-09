class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def display

    # @showCount = current_user.show_ids.count

  end

end
