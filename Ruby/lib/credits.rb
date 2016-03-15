require 'httparty'
require 'json'
class Credits

  attr_reader :crawl, :names

  def initialize(film_data)
    @crawl = film_data.fetch("opening_crawl", "")
    @names = []
    get_characters(film_data.fetch("characters"))

  end

  def get_characters(character_urls)
    character_urls.each do |url|
      @names << JSON.parse(HTTParty.get(url).body)["name"]
    end


  end

  def self.call
    request = HTTParty.get("http://swapi.co/api/films/1/")
    data = JSON.parse(request.body)


    self.new(data)
  end

end