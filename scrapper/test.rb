require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('http://www.bbc.co.uk/news/')

puts page.links
