class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
	t.column :name, :string, :limit => 32, :null => false
        t.column :house, :string, :limit => 32
        t.column :father, :integer
        t.column :mother, :integer
        t.column :year_of_birth, :integer
        t.column :year_of_death, :integer
    end
  end

  def self.down
     drop_table :people
  end

  
end
