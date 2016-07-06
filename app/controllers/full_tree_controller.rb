
class FullTreeController < ApplicationController
  def index
    @people = Person.all
    @tree_html = generateHTML(@people)
=begin 
    @tree_html = "<div class=\"tree\">
		<ul>
			<li>
				<a href=\"#\">
          <p>Eddard Stark</p>
          <p>263-299</p>
        </a><a href=\"#\">
          <p>Catelyn Stark</p>
          <p>263-299</p>
        </a>
				<ul>
					<li>
            <a href=\"#\">
              <p>Robb Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Sansa Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Arya Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Bran Stark</p>
              <p>263-299</p>
            </a>
					</li>
          <li>
            <a href=\"#\">
              <p>Rickon Stark</p>
              <p>263-299</p>
            </a>
					</li>
				</ul>
			</li>
		</ul>
	</div>"
=end
  end

  def generateHTML(people)
     return "<div class=\"tree\"><ul>" + generateHTMLPerson(people[0], people) + "</ul></div>"
  end

  def generateHTMLPerson(person, people)
     result = "<li><a href=\"#\"><p>" + person.name.to_s + "</p><p>" + person.year_of_birth.to_s + "-" + person.year_of_death.to_s + "</p></a>"
     spouse = findSpouse(person, people)
     if spouse != nil
     	result = result + "<a href=\"#\"><p>" + spouse.name.to_s + "</p><p>" + spouse.year_of_birth.to_s + "-" + spouse.year_of_death.to_s + "</p></a>"
     end
     result = result + "</li>"
     return result 
  end

  def findSpouse(person, people)
    people.each do |p|
       if person.spouse == p.id
          return p
       end
    end
    return nil
  end

 

end
