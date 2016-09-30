require 'tree_renderer'

class CharacterController < ApplicationController
  def display
        @wikilink = params[:id]
        @id = Person.where("wiki_link = ?", @wikilink).first.id
	@name = @wikilink.gsub('_',' ')
	parents = Person.where("id = ?", @id)
        children = Person.where("id = ?", @id)
        children_temp = []
	extra_spouses = []
	parents_temp = []
	while parents.count != parents_temp.count
       		parents_temp = parents
		parents.each do |person|
			parents += Person.where("id = ?", person.father)
                        parents += Person.where("id = ?", person.mother)
                end
                parents = parents.uniq
	end
	
	while children.count != children_temp.count
                children_temp = children
                children.each do |person|
                        new_children = Person.where("father = ? OR mother = ?", person.id, person.id)
			children += new_children
                        new_children.each do |child|
				extra_spouses += Person.where("id = ? OR id = ?", child.mother, child.father)
                        end
      
                end
                children = children.uniq
        end
        children += extra_spouses
 
        people = (parents + children).uniq
        people_ids = []
        people.each do |person|
		people_ids << person.id
        end
        relationships = Relationship.where(:person_1 => people_ids, :person_2 => people_ids)
	
        renderTree(@wikilink, people, relationships)
  end
end
