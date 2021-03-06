require 'tree_renderer'

class HouseController < ApplicationController
  def display
    @house = params[:name]
    people = Person.where("house = ? OR id IN (SELECT person_2 FROM people join relationships ON people.id = relationships.person_1 WHERE house = ? AND legitimate = 1)", @house, @house)
    relationships = Relationship.where("legitimate = 1 AND person_1 IN (?) AND person_2 IN (?) ", people.pluck(:id), people.pluck(:id))



    respond_to do |format|
	    format.html
	    format.json {
		render json: {"people": people, "relationships": relationships}
	    }

  end

  end
end
