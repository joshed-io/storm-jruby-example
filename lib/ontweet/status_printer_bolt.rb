require 'red_storm'

class StatusPrinterBolt < RedStorm::DSL::Bolt
  on_init do
    puts "StatusPrinterBolt init"
  end

  on_receive do |tuple|
    puts tuple[:status]
    ["ok"]
  end
end
