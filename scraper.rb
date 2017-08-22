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
	#puts firstName
	#get infobox	
	infobox =  html.css('table[class="infobox infobox-body"]')[0]
	#puts infobox
	#get titles
	titles = html.xpath('//th[contains(text(), "Title")]')[0].next_element
	titles.css('br').each{ |br| br.replace "\n"}
	puts titles.text

	#get allegiances
	allegiances = html.xpath('//th[contains(text(), "Allegiance")]')[0].next_element
	allegiances.css('br').each{ |br| br.replace "\n"}
	puts allegiances.text

	#search for first paragraph (literally first p)
	firstPara =  html.css('p')[0].text.gsub(/\[[0-9]+\]/, '')
	puts firstPara
	#get Quotes_by_[first name]
	quotesTable = html.css('span#Quotes_by_'+firstName)[0].parent.next_element
	quoteText = quotesTable.css('td')[1].text.gsub(/\[[0-9]+\]/, '')
	puts quoteText

	end
end
