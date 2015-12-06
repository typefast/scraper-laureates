require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

DATA_DIR = "nobel"
Dir.mkdir(DATA_DIR) unless File.exists?(DATA_DIR)

BASE_WIKIPEDIA_URL = 'http://en.wikipedia.org'
LIST_URL = "#{BASE_WIKIPEDIA_URL}/wiki/List_of_Nobel_laureates"

# HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}"}

page = Nokogiri::HTML(open(LIST_URL, :allow_redirections => :safe))
rows = page.css('div.mw-content-ltr table.wikitable tr')

rows[1..-2].each do |row|
  
  hrefs = row.css('td a').map { |a| 
    a['href'] if a['href'].match("/wiki/")
  }.compact.uniq
  
  hrefs.each do |href|
  
  remote_url = BASE_WIKIPEDIA_URL + href
  local_fname = "#{DATA_DIR}/#{File.basename(href)}.html"
  unless File.exists?(local_fname)
    puts "Fetching #{remote_url}"
    begin
      wiki_content = open(remote_url, :allow_redirections => :safe).read
    rescue Exception => e
      puts "Error #{e}"
      sleep 5
    else
      File.open(local_fname, 'w') { |file| file.write(wiki_content) }
      puts "\t...Success, saved to #{local_fname}"
      ensure
        sleep 1.0 + rand
    end
  end
      
  end
end

