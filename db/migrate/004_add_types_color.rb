class AddTypesColor < ActiveRecord::Migration
  def self.up
    add_column :types, :color, :string, :limit => 7, :default => "FFFFFF",    :null => false
  end

  def self.down
    remove_column :types, :color
  end
end