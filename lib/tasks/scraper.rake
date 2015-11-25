require_all './lib/scrapers'

namespace :scraper do
  desc 'Scraps GameFAQS for upcoming games'

  task :run => :environment do
    consoles = [
      '3ds',
      'wii-u',
      'ps4',
      'pc'
    ]

    consoles.each do |console|
      puts "Scrapping upcoming games for #{console}"

      scraper = GamefaqsScraper.new(console)
      scraper.run()
    end

  end

end
