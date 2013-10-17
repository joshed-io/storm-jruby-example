require 'red_storm'
require 'ontweet/status_spout'
require 'ontweet/status_printer_bolt'

class OnTweetTopology < RedStorm::DSL::Topology
  spout StatusSpout, :parallelism => 2 do
    output_fields :status
  end

  bolt StatusPrinterBolt, :parallelism => 2 do
    output_fields :ok
    source StatusSpout, :shuffle
  end
end
