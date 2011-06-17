class NotesController < ApplicationController
  load_and_authorize_resource

  def create
    @note = Note.new(params[:note])
    @note.user = current_user

    @note.save
    respond_to do |format|
      format.js
      format.html {
        url = session[:return_to] || :back
        redirect_to url, :notice => t('flash.deleted', :model => Note.model_name.human)
      }
    end
  end

  def edit
    render :layout => false if request.xhr?
  end


  def update
    @note.user = current_user

    if @note.update_attributes(params[:note])
      url = session[:return_to] || :back
      redirect_to url, :notice => t('flash.deleted', :model => Note.model_name.human)
    else
      render :action => "edit"
    end
  end

  def destroy
    @note.destroy
    url = session[:return_to] || :back
    redirect_to url, :notice => t('flash.deleted', :model => Note.model_name.human)
  end
end
