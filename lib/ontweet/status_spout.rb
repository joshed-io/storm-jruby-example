require 'red_storm'
require 'twitter'

class StatusSpout < RedStorm::DSL::Spout
  tweets = ThreadSafe::Array.new

  on_send do
    tweets.shift unless tweets.empty?
  end

  on_init do
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    Thread.new {
      client.filter(:track => "2chainz") do |tweet|
        tweets.push(tweet.text)
      end
    }
  end
end
