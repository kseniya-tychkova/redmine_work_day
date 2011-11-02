class TypeController < ApplicationController
  
  before_filter :require_admin
  
  def index
    @types = Type.find(:all)
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(params[:type])
    if @type.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Type.find(params[:id]).destroy
    redirect_to :action => 'index'
  rescue
    flash[:error] = l(:error_unable_delete_issue_status)
    redirect_to :action => 'index'
  end   
end