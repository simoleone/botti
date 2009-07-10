$: << '/tc/svn/rap_support/trunk/lib'
require 'bot_plugin_base'
require '/tc/svn/collector2/trunk/src/rb/collector_client'

module BotPlugin
  class CollectorStatusPlugin < BotPluginBase
    def initialize(muc)
      super(muc)
    end

    def process(time, nick, command)
      return false unless (command =~ /^collector /)

      Thread.new {
        begin
          host, port = command =~ /^collector ([^ ]+) (\d+)/ && $1,$2
          client = Rapleaf::Services::Collector::CollectorClient.new(host, port.to_i)
          stats = client.get_server_stats()
          @muc.say("#{nick}: collector status on #{host}:#{port} : #{stats.inspect}")
          client.close
        rescue Object => e
          @muc.say("#{nick}: collector status failed : #{e.to_s}")
        end
      }

      return true
    end
  end
end

