class SearchController < ApplicationController
  before_action :set_word_page
  def search
    @tickets = Ticket.search(@word,@page,[:uid])
  end

  def advanced_search
      redirect_to :controller=>'control' and return unless is_logged?
      @tickets = Ticket.search(@word,@page)
  end
  private 
  def set_word_page
    @word = params[:word]
    @page = params[:page]
  end
end
