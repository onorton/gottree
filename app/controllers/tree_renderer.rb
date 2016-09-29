
def renderTree(name, people, relationships)
  family_tree = GraphViz.digraph( "family" ) { |family_tree| 
      family_tree[:ratio] = 'auto'
      people.each do |p|
       family_tree.add_nodes( p.id.to_s, :style => 'filled', :href => formatLink(p, false), :fillcolor => 'white', :target => '_blank', :color => 'black', :fontcolor => 'black' , :label => '<<table align="right"  cellborder="0"  border="0" href="' + formatLink(p, true) + '"><tr><td>' + p.name + formatYears(p) + '</td></tr></table>>' , :regular => '1', :shape => 'box' )
        end 

      people.each do |p|
        rs = relationships.where('person_1 = ?', p)
        rs.each do |r|
           family_tree.add_nodes( p.id.to_s + "+" + r.person_2.to_s, :color => '', :label => '', :regular => '', :shape => 'point' )
           style = 'solid'
           if !r.legitimate
             style = 'dashed' 
           end 
           family_tree.add_edges(p.id.to_s, p.id.to_s + "+" + r.person_2.to_s, :dir=>'none', :style => style)
           family_tree.add_edges(r.person_2.to_s, p.id.to_s + "+" + r.person_2.to_s , :dir=>'none', :style => style)
        end
      end

      people.each do |p| 
  
         if p.father != 0 && p.mother != 0
            style = 'solid'
            if !family_tree.get_node(p.father.to_s + "+" + p.mother.to_s).nil?
              if !Relationship.where('person_1  = ? and person_2 = ?', p.father.to_s, p.mother.to_s).take.legitimate
                style = 'dashed'
              end
              family_tree.add_edges(p.father.to_s + "+" + p.mother.to_s, p.id.to_s, :dir=>'none', :style => style)
            end
        
            if !family_tree.get_node(p.mother.to_s + "+" + p.father.to_s).nil?
              if !Relationship.where('person_1  = ? and person_2 = ?', p.mother.to_s, p.father.to_s).take.legitimate
                style = 'dashed'
              end
              family_tree.add_edges(p.mother.to_s + "+" + p.father.to_s, p.id.to_s, :dir=>'none', :style => style)
            end
         end 
      end    
    }
  
    if name.nil?
      family_tree.output(:svg => "app/assets/images/family_tree.svg")
    else
      family_tree.output(:svg => "app/assets/images/" + name + "_family_tree.svg") 
    end
  end

  def formatYears(person)
    result = "<br/>"
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

 def formatLink(person, wikilink)
   unless person.wiki_link == "NULL"
      if (wikilink)
     	return 'http://awoiaf.westeros.org/index.php/' + person.wiki_link
      else
        return '/character/display?id=' + person.wiki_link
      end
   end
   return ''  
 end


