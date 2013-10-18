require 'red_storm'
require 'jruby/synchronized'

class WordCollectorBolt < RedStorm::DSL::Bolt
  words = ThreadSafe::Hash.new

  on_init do
    Thread.new {
      while true do
        words.sort_by { |k, v| -1 * v}[0..10].each do |k, v|
          puts "#{v} - #{k}"
        end
        puts ""
        puts ""
        sleep 5
      end
    }
  end

  on_receive do |tuple|
    current_count = words[tuple[:word]] || 0
    words[tuple[:word]] = current_count + 1
    [:ok]
  end
end
