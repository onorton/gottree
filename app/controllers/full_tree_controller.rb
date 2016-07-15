require 'graphviz'
require 'tree_renderer'

class FullTreeController < ApplicationController
  def index
    people = Person.all
    relationships = Relationship.all
    renderTree(nil, people, relationships)
  end

  def formatYears(person)
    result = "\n"
    if person.year_of_birth > 0
      result += person.year_of_birth.to_s
    elsif person.year_of_birth == -1
      result += "???"
    end
    result += "-"
    if person.year_of_death > 0
      result += person.year_of_death.to_s
    elsif person.year_of_death == -1
      result += "???"
    end
    return result
  end

 def formatLink(person)
   unless person.wiki_link == "NULL"
     return 'http://awoiaf.westeros.org/index.php/' + person.wiki_link
   end
   return ''
  
 end
end
