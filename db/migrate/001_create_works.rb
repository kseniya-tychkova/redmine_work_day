class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.column :user_id, :integer
      t.column :date, :date
      t.column :comment, :text, :default => "",  :null => false
    end
  end

  def self.down
    drop_table :works
  end
end
