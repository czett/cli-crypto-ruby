require 'httparty'
require 'json'

response = HTTParty.get('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false')

system("clear")

puts "What crypto currency are you interested in? "
currency = gets.chomp
currency.gsub(" ", "-")

if response.code == 200
  data = JSON.parse(response.body)

  crypto_info = data.find { |crypto| crypto['name'].downcase == currency.downcase }

  puts "\n"
  puts "Symbol: #{crypto_info['symbol']}"
  puts "Market Cap Rank: #{crypto_info['market_cap_rank']}"
  puts "\nPrice: $#{crypto_info['current_price']}"
  puts "24h High: $#{crypto_info['high_24h']}"
  puts "24h Low: $#{crypto_info['low_24h']}"
else
  puts "Error fetching data: #{response.code}"
end
