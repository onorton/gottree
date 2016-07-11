class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
	t.column :name, :string, :limit => 32, :null => false
        t.column :gender, :character
        t.column :house, :string, :limit => 32
        t.column :spouse, :integer
        t.column :father, :integer
        t.column :mother, :integer
        t.column :year_of_birth, :integer
        t.column :year_of_death, :integer
        t.column :wiki_link, :string, :limit => 64
    end
  end

  def self.down
     drop_table :people
  end

  
end
