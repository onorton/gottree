require 'graphviz'
require 'tree_renderer'

class FullTreeController < ApplicationController
  def index
    people = Person.all
    relationships = Relationship.all
    renderTree(nil, people, relationships)
  end

end
