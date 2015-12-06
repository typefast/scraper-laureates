require 'nokogiri'
require 'open-uri'
PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"

page = Nokogiri::HTML(open(PAGE_URL))

news_links = page.css("a[data-category=news]")
news_links.each { |link| puts link['href'] }

references_anchor = page.css("#references a")
references_anchor.each { |link| puts link['href'] }
