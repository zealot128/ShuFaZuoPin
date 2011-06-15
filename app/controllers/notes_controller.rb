class NotesController < ApplicationController
  load_and_authorize_resource

  def create
    @note = Note.new(params[:note])
    @note.user = current_user

    if @note.save
      redirect_to(@note, :notice => t('flash.created', :model => Note.model_name.human))
    else
      render :action => "new"
    end
  end

  def update
    @note = Note.find(params[:id])
    @note.user = current_user

    if @note.update_attributes(params[:note])
      redirect_to(@note, :notice => t('flash.updated', :model => Note.model_name.human))
    else
      render :action => "edit"
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to(notes_path, :notice => t('flash.deleted', :model => Note.model_name.human))
  end
end
