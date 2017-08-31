#!/usr/bin/env ruby

require 'mysql2'
require 'nokogiri'
require 'net/http'
lines = IO.readlines('characters.txt')
client = Mysql2::Client.new(:host => 'localhost', :database => 'gottree_development', :username => 'root', :password => '')
statement = client.prepare("UPDATE people SET culture = ?, quote = ?, titles = ?, allegiances = ?, description = ? WHERE id = ? ")
lines.each do |character|
	id = character.split("\t").first
	wikilink = character.split("\t").last.chomp().strip()	
 
	if (wikilink != "NULL")
	url = URI.encode('http://awoiaf.westeros.org/index.php/' + wikilink)
	puts url
	html =  Nokogiri::HTML(Net::HTTP.get(URI.parse(url)))
	firstName = wikilink.split("_").first
	#puts firstName
	#get culture	
	culture = html.xpath('//th[contains(text(), "Culture")]')[0]
	if (culture != nil)
		culture = culture.next_element.text.strip()
	end
	puts culture
	#get titles
	titles = html.xpath('//th[contains(text(), "Title")]')[0]
	if (titles != nil)
		titles = titles.next_element
		titles.css('br').each{ |br| br.replace "\n"}
		titles = titles.text.strip().gsub(/\[[0-9]+\]/, '')
	end
	puts titles

	#get allegiances
	allegiances = html.xpath('//th[contains(text(), "Allegiance")]')[0]
	if (allegiances != nil)
		allegiances = allegiances.next_element
		allegiances.css('br').each{ |br| br.replace "\n"}
		allegiances = allegiances.text.strip()
	end
	puts allegiances


	#search for first paragraph (literally first p)
	firstPara =  html.css('p')[0].text.gsub(/\[[0-9]+\]/, '')
	puts firstPara
	#get Quotes_by_[first name]
	quoteText = nil
	quotesTable = html.css('span#Quotes_by_'+firstName)[0]
	if (quotesTable != nil )
		quoteText = quotesTable.parent.next_element.css('td')[1].text.gsub(/\[[0-9]+\]/, '').strip()
	end
	puts quoteText		
	statement.execute(culture, quoteText, titles, allegiances, firstPara, id)
	end
end
