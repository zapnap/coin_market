module CoinMarket
  class Ticker
    class << self
      def get(id)
        response = CoinMarket::Client.new.request('ticker', id)
        tickers = response.map { |obj| CoinMarket::Ticker.new(obj) }
        tickers.length > 1 ? tickers : tickers[0]
      end

      def all
        get(nil)
      end
    end

    attr_reader :attributes

    def initialize(obj)
      @attributes = obj
    end

    def id; attributes['id']; end
    def name; attributes['name']; end
    def symbol; attributes['symbol']; end
    def rank; attributes['rank'].to_f; end
    def available_supply; attributes['available_supply'].to_f; end
    def total_supply; attributes['total_supply'].to_f; end

    def price(options={})
      currency = options[:currency] || 'usd'
      key = "price_#{currency}"

      attributes.has_key?(key) ? attributes[key].to_f : nil
    end

    def volume(options={})
      period = options[:period] || '24h'
      currency = options[:currency] || 'usd'
      key = "#{period}_volume_#{currency}"

      attributes.has_key?(key) ? attributes[key].to_f : nil
    end

    def market_cap(options={})
      currency = options[:currency] || 'usd'
      key = "market_cap_#{currency}"

      attributes.has_key?(key) ? attributes[key].to_f : nil
    end

    def percent_change(options={})
      period = options[:period] || '24h'
      key = "percent_change_#{period}"

      attributes.has_key?(key) ? attributes[key].to_f : nil
    end

    def last_updated
      Time.at(attributes['last_updated'].to_f)
    end
  end
end
