class CharactersController < ApplicationController
  # load_and_authorize_resource
  def index
    @characters = Character.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def edit
    @character = Character.find(params[:id])
  end

  def create
    @character = Character.new(params[:character])

    if @character.save
      redirect_to(@character, :notice => t('flash.created', :model => Character.model_name.human))
    else
      render :action => "new"
    end
  end

  def update
    @character = Character.find(params[:id])

    if @character.update_attributes(params[:character])
      redirect_to(@character, :notice => t('flash.updated', :model => Character.model_name.human))
    else
      render :action => "edit"
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to(characters_path, :notice => t('flash.deleted', :model => Character.model_name.human))
  end
end
