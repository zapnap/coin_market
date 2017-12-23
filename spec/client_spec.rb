RSpec.describe CoinMarket::Client do
  let(:client) { CoinMarket::Client.new }
  let(:btc_url) { "https://api.coinmarketcap.com/v1/ticker/bitcoin" }
  let(:etc_url) { "https://api.coinmarketcap.com/v1/ticker/ethereum-classic" }
  let(:response) { File.open(File.dirname(__FILE__) + "/sample.txt") }

  describe "request" do
    it "normalizes urls" do
      expect(client).to receive(:open).with(etc_url).and_return(response)
      res = client.request('ticker', 'Ethereum Classic')
    end

    it "makes the request and parses json" do
      res = client.request('ticker', 'bitcoin')
      expect(res.length).to eq(1)
      expect(res[0]['name']).to eq('Bitcoin')
    end

    it "rescues errors and returns no results" do
      expect_any_instance_of(CoinMarket::Client).to receive(:build_url).and_return('http://foo.bar/fiat')
      expect_any_instance_of(CoinMarket::Client).to receive(:read_url).and_raise(OpenURI::HTTPError.new('Just testing!', nil))
      expect(client.request('ticker', 'xxxfiat')).to eq([])
    end
  end
end
