require 'credits'

describe Credits do

  it "gets the correct data from api" do
    expect(HTTParty).to receive(:get).with("http://swapi.co/api/films/1/")
    Credits.call
  end
end