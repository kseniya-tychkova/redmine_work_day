class AddWorksTypeId < ActiveRecord::Migration
  def self.up
    add_column :works, :type_id, :integer
  end

  def self.down
    remove_column :works, :type_id
  end
end