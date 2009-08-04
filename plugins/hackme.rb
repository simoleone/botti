require 'bot_plugin_base'

module BotPlugin
  class HackMePlugin < BotPluginBase
    def initialize(muc, plugins)
      super(muc, plugins)
    end

    def process(time, nick, command)
      return false unless (command =~ /^hackme/)

      @muc.say("#{nick}: git clone svn.vpn.rapleaf.com:/home/simo/gitrepos/internbot.git")

      return true
    end

    def help_list(time, nick)
      return "hackme"
    end

    def help(time, nick, command)
      return false unless command =~ /^hackme$/

      @muc.say("#{nick}: hackme\nInfo on contributing to bot development")
      return true
    end

  end
end

