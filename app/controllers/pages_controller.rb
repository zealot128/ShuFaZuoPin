class PagesController < ApplicationController
  def index
    if logged_in?
      redirect_to exercises_path
    end
  end

  def impressum
    raise RuntimeError
  end


end
