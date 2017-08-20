#!/usr/bin/env ruby

require 'net/http'
lines = IO.readlines('characters.txt')
lines.each do |character|
	id = character.split("\t").first
	wikilink = character.split("\t").last
	url = URI.encode(('http://awoiaf.westeros.org/index.php/' + wikilink).chomp())
	#puts url
	puts Net::HTTP.get(URI.parse(url))
end
