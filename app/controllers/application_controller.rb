class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
  
    @hero_unit = true
    respond_to do |format|
      format.html {render "home/home"}
    end
  end
end
