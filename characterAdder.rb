#!/usr/bin/env ruby
def createCharacter
	puts "Creating character\n"
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




