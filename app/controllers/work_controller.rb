class WorkController < ApplicationController
  unloadable
  before_filter :require_login, :find_users, :get_date
    
  def index
    @types = Type.find(:all)
    
    case params[:format]
    when 'xml', 'json'
      @offset, @limit = api_offset_and_limit
    else
      @limit = per_page_option
    end
       
    @user_count = @users.size
    @user_pages = Paginator.new self, @user_count, @limit, params['page']
    @offset ||= @user_pages.current.offset

  end
  
  def edit
    @types = Type.find(:all)
    
    case params[:format]
    when 'xml', 'json'
      @offset, @limit = api_offset_and_limit
    else
      @limit = per_page_option
    end
       
    @user_count = @users.size
    @user_pages = Paginator.new self, @user_count, @limit, params['page']
    @offset ||= @user_pages.current.offset
    
    @work = Work.find(:all, :conditions => ["user_id=(:user)", {:user => User.current.id}])
  end
  
  def update
    
    @types = Type.find(:all)
    
    case params[:format]
    when 'xml', 'json'
      @offset, @limit = api_offset_and_limit
    else
      @limit = per_page_option
    end
       
    @user_count = @users.size
    @user_pages = Paginator.new self, @user_count, @limit, params['page']
    @offset ||= @user_pages.current.offset
    
    if params
    dates = params[:work] if params[:work]
    comment = params[:comment][:comment_text] if params[:comment] && params[:comment][:comment_text]
    type_id = params[:type][:type_id] if params[:type] && params[:type][:type_id]
    end
    if dates && type_id && !dates.empty? && !type_id.empty?
      dates.each do |date|
      work = Work.find(:first, :conditions => ["user_id=(:user) and date=(:day)", {:user => User.current.id, :day => date[0]}])
      if work
        unless work.update_attributes(:comment => comment, :type_id => type_id.to_i)
           render :action => 'edit'
           break
        end
      else
        work = Work.new
          work.user_id = User.current.id
          work.date = date[0]
          work.comment = comment
          work.type_id = type_id.to_i
        unless work.save
          render :action => 'edit'
          break
        end
      end
      end
    redirect_to :action => 'index'
  else
    flash[:error] = "Select type and check days. Add types in plugin settings if types field is empty"
    redirect_to :action => 'edit'
  end
  end
    
private 
  def find_users
    @users = [User.current]
    active_users = User.active
    active_users.sort{ |a,b| a.name <=> b.name } 
    @users << active_users
    @users.flatten! if @users.respond_to?(:flatten!)
    @users.uniq! if @users.respond_to?(:uniq!)
  end
  
  def get_date
   date_from = Date.today - 5
   date_to = (Date.today >> 1) - 5
   dates = []
   date = date_from
   while date < date_to
     dates << date
     date = date + 1
   end
   monthes = dates.collect{|d| d.month}.uniq!
   @colspan = {}
   monthes.each do |m|
     @colspan[m] = (dates.select{|d| d.month == m}).length
   end
   return @colspan
 end
  
end