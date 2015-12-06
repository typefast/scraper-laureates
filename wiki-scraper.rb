require 'nokogiri'
require 'open-uri'


PAGE_URL = "https://en.wikipedia.org/wiki/HTML"

page = Nokogiri::HTML(open(PAGE_URL))

summary_label = page.css("table.infobox th[scope=row] a")
summary_label.each { |summary| puts summary.text }


