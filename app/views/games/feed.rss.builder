#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Upcoming Game List"
    xml.author "Sifu"
    xml.description "Scraps GameFAQS for upcoming games"
    xml.link "localhost"
    xml.language "en"

    for game in @games
      xml.item do
        xml.title ("[" + game.console + "] " + game.name)
        xml.pubDate game.release_date.to_s(:rfc822)
        xml.link game.boxart
        xml.description (game.region + "," + game.tags)
      end
    end

  end
end
