require 'httparty'
require 'json'
class Credits

  attr_reader :crawl

  def initialize(film_data)
    @crawl = film_data.fetch("opening_crawl", "")
  end

  def self.call
    request = HTTParty.get("http://swapi.co/api/films/1/")
    data = JSON.parse(request.body)


    self.new(data)
  end

end