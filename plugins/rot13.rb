require 'bot_plugin_base'

module BotPlugin
  class Rot13Plugin < BotPluginBase
    def initialize(muc)
      super(muc)
    end

    def process(time, nick, command)
      return false unless (command =~ /^rot13 /)
      
      msg = command =~ /^rot13 (.*)/ && $1
      @muc.say("#{nick}: #{msg.tr! "A-Za-z", "N-ZA-Mn-za-m"}")

      return true
    end
  end
end

