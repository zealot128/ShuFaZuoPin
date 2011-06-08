class PagesController < ApplicationController
  def index
    if logged_in?
      render :controller => :exercises
    end
  end

  def impressum
  end

end
