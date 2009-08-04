require 'bot_plugin_base'

module BotPlugin
  class RetortPlugin < BotPluginBase
    def initialize(muc, plugins)
      super(muc, plugins)
    end

    def process(time, nick, command)
      return false unless (command =~ /^you /)
      
      msg = command =~ /^you (.*)/ && $1
      @muc.say("#{nick}: no YOU #{msg}")

      return true
    end

    def help_list(time, nick)
      return nil
    end

    def help(time, nick, command)
      return false
    end
  end
end

