class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.column :person_1, :integer
      t.column :person_2, :integer
      t.column :legitimate, :boolean

    end
  end
end
