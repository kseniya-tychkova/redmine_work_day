module WorkHelper
  
  def work_day(user,day)
    work = Work.find(:first, :conditions => ["user_id=(:user) and date=(:day)", {:user => user.id, :day => day}])
    if work 
      return work
    else
      return ""
    end
  end
  
end