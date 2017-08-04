class WelcomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @ids = current_user.show_ids

    # randomly pick a show from users collection to use for suggesting other shows
    unless @ids.length <= 1
      val = @ids.sample

      val = @ids.sample
      check = Show.select("shid, poster").find(val)
      while (check.shid.nil?)
        val = @ids.sample
        check = Show.select("shid, poster").find(val)
      end

      @selectedShow = check;
    end

  end

end
