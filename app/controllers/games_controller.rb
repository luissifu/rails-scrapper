class GamesController < ApplicationController

  def index
    @games = Game.order(:release_date)
    @games = @games.where(console: params[:consoles]) if params[:consoles]
    @games = @games.where(region: params[:regions]) if params[:regions]

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

end
