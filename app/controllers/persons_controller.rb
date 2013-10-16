class PersonsController < ApplicationController
  before_filter :redis_redic_bug

  def redis_redic_bug
    Person.redis='BUG'
  end

  def index
    @persons = Person.all
  end

  def show
    @person = Person.find(:name => params[:id]).first
  end
end
