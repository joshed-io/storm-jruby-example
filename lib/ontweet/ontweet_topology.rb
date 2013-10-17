require 'red_storm'
require 'ontweet/status_spout'
require 'ontweet/status_splitter_bolt'
require 'ontweet/word_collector_bolt'

class OnTweetTopology < RedStorm::DSL::Topology
  spout StatusSpout, :parallelism => 2 do
    output_fields :status
  end

  bolt StatusSplitterBolt, :parallelism => 2 do
    output_fields :word
    source StatusSpout, :shuffle
  end

  bolt WordCollectorBolt, :parallelism => 1 do
    output_fields :ok
    source StatusSplitterBolt, :fields => ["word"]
  end

  configure do |env|
    max_task_parallelism 2
    num_workers 2
    max_spout_pending 1000
  end
end
