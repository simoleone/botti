require 'bot_plugin_base'

module BotPlugin
  class RetortPlugin < BotPluginBase
    def initialize(muc)
      super(muc)
    end

    def process(time, nick, command)
      return false unless (command =~ /^you /)
      
      msg = command =~ /^you (.*)/ && $1
      @muc.say("#{nick}: no YOU #{msg}")

      return true
    end
  end
end

