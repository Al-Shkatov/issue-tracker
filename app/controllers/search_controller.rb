class SearchController < ApplicationController
  before_action :set_word
  def search
    @tickets = Ticket.search(@word,[:uid])
  end

  def advanced_search
    @tickets = Ticket.search(@word)
  end
  private 
  def set_word
    @word = params[:search]
  end
end
