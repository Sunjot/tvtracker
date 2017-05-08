class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Ensure that a user is logged in
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path
    end
  end

end
