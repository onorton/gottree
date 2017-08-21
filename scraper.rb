#!/usr/bin/env ruby
require 'nokogiri'
require 'net/http'
lines = IO.readlines('characters.txt')
lines.each do |character|
	id = character.split("\t").first
	wikilink = character.split("\t").last.chomp()
	if (wikilink != "NULL")
	url = URI.encode('http://awoiaf.westeros.org/index.php/' + wikilink)
	puts url
	html =  Nokogiri::HTML(Net::HTTP.get(URI.parse(url)))
	firstName = wikilink.split("_").first
	puts firstName
	#get infobox
	#search for first paragraph (directly after infobox)
	#get Quotes_by_[first name]
	puts html
	end
end