require_all './lib/scrapers'

namespace :scraper do
  desc 'Scraps GameFAQS for upcoming games'

  task :run => :environment do
    consoles = [
      '3ds',
      # 'pc',
      # 'ps4',
      # 'wii-u',
    ]

    all_games = []

    consoles.each do |console|
      puts "Scrapping upcoming games for #{console}"

      scraper = GamefaqsScraper.new(console)
      this_console_games = scraper.run()
      all_games = all_games + this_console_games
    end

    all_games.each do |g|
      game = Game.where(console: g.console).where(name: g.name)

      if game.blank?
        ng = Game.create(g.to_hash)
      else
        game.update_all(boxart: game.boxart, release_date: game.release_date)
      end

    end

  end

end
