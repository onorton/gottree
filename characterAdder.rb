#!/usr/bin/env ruby
def createCharacter
        puts "Creating character...\n\n"
        total_string = ""
        total_string +=  (IO.readlines('characters.txt').last.split(" ")[0].to_i+1).to_s + "\t"
        puts "Please enter the character's name:\n"
        total_string += gets.chomp + "\t"
       
	puts "Please enter the character's gender (M, F, or NULL):\n"
        gender = gets.chomp
        if gender.empty?
        	total_string += "NULL"   
        else
        	total_string += gender
        end
        total_string += "\t"
        
	puts "Please enter the character's house (or NULL):\n"
        house = gets.chomp
        if house.empty?
        	total_string += "NULL"   
        else
        	total_string += house
        end
        total_string += "\t"
     
	puts "Please enter the character's father (or NULL):\n"
        father = gets.chomp
        if father.empty?
        	total_string += "NULL"   
        else
        	total_string += father
        end
        total_string += "\t"
        
	puts "Please enter the character's mother (or NULL):\n"
        mother = gets.chomp
        if mother.empty?
        	total_string += "NULL"   
        else
        	total_string += mother
        end
        total_string += "\t"

	puts "Please enter the character's year of birth (or -1):\n"
        year_of_birth = gets.chomp
        if year_of_birth.empty?
        	total_string += "-1"   
        else
        	total_string += year_of_birth
        end
        total_string += "\t"

	puts "Please enter the character's year of death (or NULL for alive or -1):\n"
        year_of_death = gets.chomp
        if year_of_death.empty?
        	total_string += "NULL"   
        else
        	total_string += year_of_death
        end
        total_string += "\t"


	puts "Please enter the character's wiki link (or NULL):\n"
        wiki_link = gets.chomp
        if wiki_link.empty?
        	total_string += "NULL"   
        else
        	total_string += wiki_link
        end

	open('characters.txt', 'a') { |f|
                 f.puts total_string
        }

       puts "Character added to characters.txt\n"
end

def addRelationship
        puts "Adding relationship\n"
end

puts "Welcome to character adder.\n"

done = false
while !done do
        puts "Would you like to:\n"
        puts "\t1. Add a new character\n"
        puts "\t2. Add a new relationship\n"
        puts "Hit q to quit\n\n"
        choice = gets.chomp
        case choice
        when "1"
         createCharacter()
        when "2"
         addRelationship()
        else
          done = true
        end
end




