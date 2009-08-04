require 'bot_plugin_base'

module BotPlugin
  class Rot13Plugin < BotPluginBase
    def initialize(muc, plugins)
      super(muc, plugins)
    end

    def process(time, nick, command)
      return false unless (command =~ /^rot13 /)
      
      msg = command =~ /^rot13 (.*)/ && $1
      @muc.say("#{nick}: #{msg.tr! "A-Za-z", "N-ZA-Mn-za-m"}")

      return true
    end

    def help_list(time, nick)
      return "rot13 <text>"
    end

    def help(time, nick, command)
      return false unless command =~ /^rot13$/

      @muc.say("#{nick}: rot13 <text>\nRuns the ROT13 algorithm on text.")
      return true
    end
  end
end

