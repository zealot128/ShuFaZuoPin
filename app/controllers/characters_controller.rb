class CharactersController < ApplicationController
  load_and_authorize_resource
  include ActionView::Helpers::TextHelper
  def index

    respond_to do |format|
      format.html {
        Tabulatr.paginate_options({page: 1, pagesize: 30, pagesizes: [10,20,50,100]})
        @characters = Character.find_for_table(params)
      }
      format.json {
        data = Character.find_for_ajax(params[:term])
        data.map!{|i| { value: i.id, label: "#{i.hanzi}, #{i.pinyin} - #{truncate(i.translation)}"}}
        render json: data
      }
    end
  end

  def show
    @character = Character.find(params[:id])
    render :layout => false if request.xhr?
  end

  def new
    @character = Character.new
  end

  def edit
    @character = Character.find(params[:id])
    render :layout => false if request.xhr?
  end

  def create
    para = params[:character] || params[:word]
    @character = Character.new(para)

    if @character.save
      redirect_to(@character, :notice => t('flash.created', :model => Character.model_name.human))
    else
      render :action => "new"
    end
  end

  def update
    @character = Character.find(params[:id])
    para = params[:character] || params[:word]


    if @character.update_attributes(para)
      redirect_to(root_path, :notice => t('flash.updated', :model => Character.model_name.human))
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
