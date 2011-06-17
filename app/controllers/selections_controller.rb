class SelectionsController < ApplicationController
  load_and_authorize_resource
  def index
    @selections = Selection.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @note = Note.new(:public => true)
    @note.character = @selection.character
    @notes = current_user.notes_for(@selection.character)
    render :layout => false if request.xhr?
  end

  def new
    @selection = Selection.new
    render :layout => false if request.xhr?
  end

  def edit
  end

  def create
    @selection = Selection.new(params[:selection])
    @selection.user = current_user

    if @selection.save
      expire_fragment "level-#{current_user.id}-1-0"
      expire_fragment "level-#{current_user.id}-2-0"
      redirect_to(root_url, :notice => t('flash.created', :model => Selection.model_name.human))
    else
      render :action => "new"
    end
  end

  def update
    if @selection.update_attributes(params[:selection])
      redirect_to(root_url, :notice => t('flash.updated', :model => Selection.model_name.human))
    else
      render :action => "edit"
    end
  end

  def destroy
    expire_fragment( "level-#{current_user.id}-1-#{@selection.level_1}" )
    expire_fragment( "level-#{current_user.id}-2-#{@selection.level_2}" )
    @selection.destroy
    redirect_to(root_url, :notice => t('flash.deleted', :model => Selection.model_name.human))
  end
end
