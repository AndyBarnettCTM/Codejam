require 'credits'

describe Credits do

  let(:data){File.read('./spec/data.json')}
  let(:character){File.read('./spec/character.json')}
  let(:httparty_response){double :response, {body: data}}
  let(:character_data){double :response, {body: character}}

  before {allow(HTTParty).to receive(:get).and_return(character_data)}

  it "gets the correct data from api" do
    expect(HTTParty).to receive(:get).with("http://swapi.co/api/films/1/").and_return(httparty_response)
    Credits.call
  end

  it "can store the opening credits" do
    allow(HTTParty).to receive(:get).with("http://swapi.co/api/films/1/").and_return(httparty_response)
    credits = Credits.call

    expect(credits.crawl).to eq "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy...."
  end

  it "can get character URLs" do
    allow(HTTParty).to receive(:get).with("http://swapi.co/api/films/1/").and_return(httparty_response)
    credits = Credits.call
    allow(JSON).to receive(:parse).and_return({"characters" => ["https://donestmatter"]})
    expect(credits.names).to eq ["Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker", "Luke Skywalker"]
  end
end