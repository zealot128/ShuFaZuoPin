# encoding: utf-8
class ExercisesController < ApplicationController
  def index
    authorize! :read, Character
    if current_user.nil?
      redirect_to login_path
      return
    end
  end

  def tooltip
    @character = Character.find_by_hanzi(params[:q])
    render :layout => false
  end

  def show
    authorize! :read, Character
    @exercise = EXERCISES.find{|i| i[:id] == params[:id].to_i}
    @selection = Selection.find_next(current_user.id, params[:id].to_i)
  end

  def update
    authorize! :read, Character
    ex_id = params[:id]
    @selection = current_user.selections.find(params[:selection_id])
    @selection.inc_stat ex_id, :visited
    message = ""
    case params[:answer]
      when "right" then
        @selection.right(ex_id)
        @selection.inc_stat ex_id, :correct
        @selection.save
        message = "Wort richtig!"
      when "wrong" then
        @selection.wrong(ex_id)
        @selection.wrong(ex_id)
        @selection.save
        message = "Wort falsch"
      when "mamahuhu" then
        @selection.right(ex_id)
        @selection.wrong(ex_id)
        @selection.inc_stat ex_id, :wrong
        @selection.save
        message = "Nicht richtig gewusst? Wort-Stufe hat sich nicht verändert"
      else raise "Type not found"
    end
    redirect_to exercise_path(ex_id), :notice => message
  end

end
