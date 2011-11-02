require 'redmine'

Redmine::Plugin.register :redmine_work_day do
  name 'Redmine Work Day plugin'
  author 'Kseniya Tychkova'
  description 'A plugin to view and update work days by each user'
  version '0.0.1'
  
  settings :partial => 'settings/works_settings'
  
  menu :account_menu, :work, {:controller => 'work', :action => 'index'}, :caption => :work_title, :if => Proc.new { User.current.logged? }
end
