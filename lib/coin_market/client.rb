require "open-uri"

module CoinMarket
  class Client
    @@api_version = 'v1'
    @@base_uri = "https://api.coinmarketcap.com/v1"

    attr_accessor :api_key, :limit, :start, :convert

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
    end

    def request(endpoint, id=nil, options={})
      res = read_url(build_url(endpoint, id, options))
      JSON.parse(res)
    rescue OpenURI::HTTPError => e
      puts "ERROR: #{e}"
      []
    end

    private

    def build_url(endpoint, id, options={})
      id = id.downcase.gsub(/\s/, '-').gsub(/[^\w-]/, '') unless id.nil?
      url = [@@base_uri, endpoint, id].compact.join('/')
    end

    def read_url(url)
      open(url).read
    end
  end
end
