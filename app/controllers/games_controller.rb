class GamesController < ApplicationController
  def index
    @games = Game.order(:release_date)
  end
end
