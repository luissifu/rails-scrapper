require_all './lib/scrapers'

namespace :scraper do
  desc 'Scraps GameFAQS for upcoming games'

  task :run => :environment do

    consoles = [
      '3ds',
      'pc',
      'ps4',
      'vita',
      'wii-u',
      'xboxone'
    ]

    all_games = []

    consoles.each do |console|
      puts "Scrapping upcoming games for #{console}"

      scraper = GamefaqsScraper.new(console)
      this_console_games = scraper.run()

      puts "Found #{this_console_games.count} games for #{console}"

      all_games = all_games + this_console_games
    end

    all_games.each do |g|
      game = Game.where(console: g.console).where(name: g.name).where(region: g.region)

      if game.blank?
        Game.create(g.to_hash)
      else
        game = game.first
        game.boxart = g.boxart if game.boxart != g.boxart
        game.release_date = g.release_date if game.release_date != g.release_date
        game.save
      end

    end

  end

end
