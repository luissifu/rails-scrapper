class GamesController < ApplicationController

  def index
    @games = Game.order(:release_date)
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end


end
