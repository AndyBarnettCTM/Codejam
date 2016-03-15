require 'httparty'
class Credits

  def self.call
    HTTParty.get("http://swapi.co/api/films/1/")

  end

end