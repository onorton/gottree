require 'graphviz'
require 'tree_renderer'

class FullTreeController < ApplicationController
  def index
	
	 #people = Person.where("use = 'Baratheon' OR house = 'Martell' OR id IN (SELECT person_2 FROM people join relationships ON people.id = relationships.person_1  WHERE house = 'Lannister' OR house = 'Tyrell' OR house = 'Targaryen' OR house = 'Stark' OR house = 'Tully' OR house = 'Arryn' OR house = 'Baratheon' OR house = 'Martell')")
    #relationships = Relationship.where("person_1 IN (?) AND person_2 IN (?) ", people.pluck(:id), people.pluck(:id))


	  
	people = Person.all
relationships = Relationship.all
    respond_to do |format|
	    format.html
	    format.json {
		render json: {"people": people, "relationships": relationships}
	    }
  end


  end

  def search
     if params[:query]
         @characters = Person.searchCharacters(params[:query])
         @houses = Person.searchHouses(params[:query])
     end
  end

end
