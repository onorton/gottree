require 'graphviz'

class FullTreeController < ApplicationController
  def index
    @people = Person.all
  
    GraphViz.parse( "family_tree.dot") {|g|}.output(:svg => "app/assets/images/family_tree.svg") 
  end

  def generateHTML(people)
     return "<div class=\"tree\"><ul>" + generateHTMLPerson(people[0], people) + "</ul></div>"
  end

  def generateHTMLPerson(person, people)
     result = "<li><a href=\"#\"><p>" + person.name.to_s + "</p><p>" + checkYear(person.year_of_birth) + "-" + checkYear(person.year_of_death) + "</p></a>"
     spouse = findSpouse(person, people)
     if spouse != nil
     	result = result + "<a href=\"#\"><p>" + spouse.name.to_s + "</p><p>" + checkYear(spouse.year_of_birth) + "-" + checkYear(spouse.year_of_death) + "</p></a>"
     end
     children = findChildren(person, people)
     if children.count != 0
        result = result + "<ul>"
        children.each do |c|
          result = result + generateHTMLPerson(c, people)
        end
        result = result + "</ul>"
     end 
     result = result + "</li>"
     return result 
  end

  def checkYear(year)
     unless year == 0
        return year.to_s
     end
     return ""
  end

  def findSpouse(person, people)
    people.each do |p|
       if person.spouse == p.id
          return p
       end
    end
    return nil
  end

  def findChildren(person, people)
    children = Array.new
    people.each do |c|
       if person.id == c.father or person.id == c.mother
          children.insert(0, c)
       end
    end
    return children.reverse
  end


 

end
