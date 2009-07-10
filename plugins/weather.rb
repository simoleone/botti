require 'bot_plugin_base'

require 'rubygems'
require 'yahoo-weather'

module BotPlugin
  class Rot13Plugin < BotPluginBase
    def initialize(muc)
      super(muc)
    end

    def process(time, nick, command)
      return false unless (command =~ /^weather/)
      
      Thread.new {
        loc = command =~/^weather(.*)/ && $1
        loc = loc.strip
        loc = loc.empty? ? "94105" : loc
        wclient = YahooWeather::Client.new
        begin
          resp = wclient.lookup_location(loc)
          @muc.say("#{nick}: #{resp.title} : #{resp.condition.temp}f - #{resp.condition.text}")
        rescue NoMethodError => e
          @muc.say("#{nick}: no such location")
        end
      }

      return true
    end
  end
end

