class Person < ActiveRecord::Base

def self.searchCharacters(search)
  where("name LIKE ? AND wiki_link IS NOT  NULL", "%#{search}%").order(:name) 
end

def self.searchHouses(search)
  where("house LIKE ?", "%#{search}%").select("distinct house").order(:house)
end

end
