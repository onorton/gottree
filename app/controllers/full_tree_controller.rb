class FullTreeController < ApplicationController
  def index
    @people = Person.all
  end
end
