
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "coin_market/version"

Gem::Specification.new do |spec|
  spec.name          = "coin_market"
  spec.version       = CoinMarket::VERSION
  spec.authors       = ["Nick Plante"]
  spec.email         = ["nap@zerosum.org"]

  spec.summary       = %q{Fetch current market data for top cryptocurrencies using the CoinMarketCap API}
  spec.description   = %q{Fetch current market data for top cryptocurrencies using the CoinMarketCap API}
  spec.homepage      = "https://github.com/zapnap/coin_market"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
