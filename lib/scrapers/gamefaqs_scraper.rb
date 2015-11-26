class GamefaqsScraper

  attr_accessor :base_url, :console

  def initialize(console)
    self.base_url = "http://www.gamefaqs.com"
    self.console = console
  end

  def run
    endpoint = "#{self.base_url}/#{self.console}/upcoming"
    page = Mechanize.new.get(endpoint)
    trs = page.search('//div[contains(@class,"post_content")]//tr')

    today = Time.current.to_date
    games = []
    last_game = nil

    # iterar por todos los juegos
    trs.each do |tr|
      tds = tr.xpath('td')

      date = tds[0].inner_text.strip
      region = tds[1].inner_text.strip
      anchor = tds[2].children[0]
      name = anchor.inner_text.strip
      boxart, tags = get_boxart_n_tags(anchor['href'])

      if date.empty?
        release_date = last_game.release_date
      else
        release = today.year.to_s + '/' + date
        release_date = Date.strptime(release, '%Y/%m/%d')
        if release_date < today
          release_date += 1.year
        end
      end

      if region.empty?
        region = last_game.region
      end

      game = ScrapedGame.new
      game.console = console
      game.name = name
      game.region = region
      game.boxart = boxart
      game.tags = tags.join(',')
      game.release_date = release_date

      games << game
      last_game = game
    end

    games
  end

  def get_boxart_n_tags(game_url)
    game_endpoint = "#{self.base_url}#{game_url}"
    game_page = Mechanize.new.get(game_endpoint)

    tags = game_page.search('//nav[contains(@class,"crumbs")]//li').map { |e| e.inner_text.strip }
    tags.shift

    game_info = game_page.search('//div[contains(@class,"pod_gameinfo")]/div[contains(@class,"body")]//li')
    boxart =  game_info[0].children[0].children[0]['src']

    devs = game_info[2].inner_text.strip
    tags << devs

    game_info.drop(4).each do |etag|
      text = etag.inner_text.strip

      if text.include? 'Also on'
        tags << 'Multiplat'
      elsif text.include? 'Expansion for'
        tags << 'DLC'
      elsif text.include? 'Chapter for'
        tags << 'Chapters'
      elsif text.include? 'Also Known As'
        tags << 'Alt Titles'
      elsif text.include? 'Franchise'
        tags << 'Franchise'
      elsif text.include? 'MetaCritic'
        tags << 'Reviewed'
      elsif text.include? 'See Also'
        tags << 'Different Versions'
      else
        rating = text.scan(/.*\((.*)\).*/)
        if rating
          tags << rating
        end
      end

    end

    [boxart, tags]
  end

end
