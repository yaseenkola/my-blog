class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  add_flash_types :danger, :success
  
  def after_sign_in_path_for(resource)
   welcome_path
  end
  
end
