require 'graphviz'
require 'tree_renderer'

class FullTreeController < ApplicationController
  def index
    people = Person.all
    relationships = Relationship.all
    renderTree(nil, people, relationships)
  end

  def search
     if params[:query]
         @characters = Person.searchCharacters(params[:query])
         @houses = Person.searchHouses(params[:query])
     end
  end

end
