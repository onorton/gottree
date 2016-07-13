require 'graphviz'

class FullTreeController < ApplicationController
  def index
    @people = Person.all

    family_tree = GraphViz.digraph( "family" ) { |family_tree| 
      family_tree[:ratio] = 'auto'
      @people.each do |p|
        family_tree.add_nodes( p.id.to_s, :href => formatLink(p), :target => '_blank', :color => 'black', :label => p.name + formatYears(p), :regular => '1', :shape => 'box' )
        end 

      @people.each do |p|
        relationships = Relationship.where('person_1 = ?', p.id)
        relationships.each do |r|
           family_tree.add_nodes( p.id.to_s + "+" + r.person_2.to_s, :color => '', :label => '', :regular => '', :shape => 'point' ) 
           family_tree.add_edges(p.id.to_s, p.id.to_s + "+" + r.person_2.to_s, :dir=>'none')
           family_tree.add_edges(r.person_2.to_s, p.id.to_s + "+" + r.person_2.to_s , :dir=>'none')
        end 
  
         if p.father != 0 && p.mother != 0
            if !family_tree.get_node(p.father.to_s + "+" + p.mother.to_s).nil?
              family_tree.add_edges(p.father.to_s + "+" + p.mother.to_s, p.id.to_s, :dir=>'none')
            end
        
            if !family_tree.get_node(p.mother.to_s + "+" + p.father.to_s).nil?
              family_tree.add_edges(p.mother.to_s + "+" + p.father.to_s, p.id.to_s, :dir=>'none')
            end
         end 
      end    
    }
  
    family_tree.output(:svg => "app/assets/images/family_tree.svg") 
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
