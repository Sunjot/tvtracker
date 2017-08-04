class InfoController < ApplicationController

  before_filter :authenticate_user!

  def about
  end
  
end
