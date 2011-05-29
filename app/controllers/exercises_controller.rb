class ExercisesController < ApplicationController
  def index
  end

  def add_word
    render :layout => false if request.xhr?
  end

end
