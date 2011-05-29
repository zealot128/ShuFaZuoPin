class <%= controller_class_name %>Controller < ApplicationController
  # load_and_authorize_resource
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>

    respond_to do |format|
      format.html
    end
  end

  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>

    if @<%= orm_instance.save %>
      redirect_to(@<%= singular_table_name %>, :notice => t('flash.created', :model => <%= class_name %>.model_name.human))
    else
      render :action => "new"
    end
  end

  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      redirect_to(@<%= singular_table_name %>, :notice => t('flash.updated', :model => <%= class_name %>.model_name.human))
    else
      render :action => "edit"
    end
  end

  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    redirect_to(<%= plural_table_name %>_path, :notice => t('flash.deleted', :model => <%= class_name %>.model_name.human))
  end
end
