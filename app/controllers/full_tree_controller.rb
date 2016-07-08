require 'graphviz'

class FullTreeController < ApplicationController
  def index
    @people = Person.all

    family_tree = GraphViz.digraph( "family" ) { |family_tree| 
      family_tree[:ratio] = 'auto'
      @people.each do |p|
        family_tree.add_nodes( p.id.to_s, :href => 'http://www.google.com', :color => 'black', :label => p.name + formatYears(p), :regular => '1', :shape => 'box' )
      end

      @people.each do |p|
         if p.spouse != 0 && family_tree.get_node(p.spouse.to_s + "+" + p.id.to_s).nil? 
           family_tree.add_nodes( p.id.to_s + "+" + p.spouse.to_s, :color => '', :label => '', :regular => '', :shape => 'point' ) 
           family_tree.add_edges(p.id.to_s, p.id.to_s + "+" + p.spouse.to_s, :dir=>'none')
           family_tree.add_edges(p.spouse.to_s, p.id.to_s + "+" + p.spouse.to_s , :dir=>'none')
         end
      end

      @people.each do |p|
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
    unless person.year_of_birth == 0
      result += person.year_of_birth.to_s
    end
    result += "-"
    unless person.year_of_death == 0
      result += person.year_of_death.to_s
    end
    return result
 
  end
end
