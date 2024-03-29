class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.column :name, :string, :limit => 30, :default => "", :null => false
    end
  end

  def self.down
    drop_table :types
  end
end