class HouseController < ApplicationController
  def index
    @house = params[:house]
    @people = Person.where("house = ? OR gender = 'F' AND spouse IN (SELECT id FROM people WHERE house = ?)", @house, @house) 
  end
end
