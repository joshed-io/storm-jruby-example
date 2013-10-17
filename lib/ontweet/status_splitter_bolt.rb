require 'red_storm'

class StatusSplitterBolt < RedStorm::DSL::Bolt
  on_receive do |tuple|
    tuple[:status].split.map do |v|
      [v]
    end
  end
end
