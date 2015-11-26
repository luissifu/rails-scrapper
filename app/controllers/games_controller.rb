class GamesController < ApplicationController

  def index
    @games = Game.order(:release_date)
  end

  def feed
    @games = Game.order(:release_date)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

end
