require 'graphviz'
require 'tree_renderer'

class FullTreeController < ApplicationController
  def index
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
