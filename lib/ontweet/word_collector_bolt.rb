require 'red_storm'

class WordCollectorBolt < RedStorm::DSL::Bolt
  words = ThreadSafe::Hash.new

  on_init do
    Thread.new {
      while true do
        words.sort_by { |k, v| -1 * v}[0..10].each do |k, v|
          if v > 10
            puts "#{v} - #{k}"
          end
        end
        puts ""
        puts ""
        sleep 10
      end
    }
  end

  on_receive do |tuple|
    current_count = words[tuple[:word]] || 0
    words[tuple[:word]] = current_count + 1
    [:ok]
  end
end
