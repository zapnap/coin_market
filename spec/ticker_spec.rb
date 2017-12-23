RSpec.describe CoinMarket::Ticker do
  let(:response) { File.open(File.dirname(__FILE__) + "/sample.txt") }
  let(:ticker) { CoinMarket::Ticker.new(JSON.parse(response.read)[0]) }

  describe ".get" do
    it "returns a ticker object" do
      ticker = CoinMarket::Ticker.get('bitcoin')
      expect(ticker.name).to eq('Bitcoin')
      expect(ticker.symbol).to eq('BTC')
    end

    it "returns nil if the ticker is not found" do
      expect_any_instance_of(CoinMarket::Client).to receive(:request).and_return([])
      expect(CoinMarket::Ticker.get('fiat')).to eq(nil)
    end
  end

  describe ".all" do
    it 'returns an array of the top 100 token tickers by market cap' do
      tickers = CoinMarket::Ticker.all
      expect(tickers.length).to eq(100)
      expect(tickers.first.class).to eq(CoinMarket::Ticker)
      expect(tickers.map(&:name)[0..1]).to eq(['Bitcoin', 'Ethereum'])
    end
  end

  describe "price" do
    it "returns a numeric value" do
      expect(ticker.price).to eq(15530.5)
    end

    it "returns price in another currency" do
      expect(ticker.price(currency: 'btc')).to eq(1.0)
    end
  end

  describe "volume" do
    it "returns the correct data for the period" do
      expect(ticker.volume).to eq(14503800000.0)
    end

    it "returns nil if the period is unknown" do
      expect(ticker.volume(period: '30d')).to eq(nil)
    end
  end

  describe "market_cap" do
    it "returns the correct data for the currency" do
      expect(ticker.market_cap).to eq(260279143862.0)
    end

    it "returns nil if the currency is unknown" do
      expect(ticker.market_cap(currency: 'bbq')).to eq(nil)
    end
  end

  describe "percent_change" do
    it "returns the correct data for the period" do
      expect(ticker.percent_change).to eq(10.16)
      expect(ticker.percent_change(period: '1h')).to eq(2.05)
      expect(ticker.percent_change(period: '7d')).to eq(-19.14)
    end

    it "returns nil if the period is unknown" do
      expect(ticker.percent_change(period: '30d')).to eq(nil)
    end
  end

  describe "last_updated" do
    it "returns a timestamp" do
      expect(ticker.last_updated).to eq(Time.parse('2017-12-23 16:14:15 -0500'))
    end
  end
end
