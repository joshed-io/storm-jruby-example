require "twitter"

describe "TwitterStreaming" do
  before do
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  it "should stream tweets" do
    tweets = []
    Thread.new {
      @client.sample do |tweet|
        tweets << tweet.text
      end
    }
    sleep(1)
    tweets.should_not be_empty
  end
end
