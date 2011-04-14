require 'bot_plugin_base'
require '/home/simo/rapleaf/path/mnt/tc/svn/admin/trunk/include/raplite/lib/prolite'

module BotPlugin
  class RaplitePlugin < BotPluginBase
    def initialize(muc, plugins)
      super(muc, plugins)
    end

    def process(time, nick, command)
      return false unless (command =~ /^raplite /)

      Thread.new {
        msg = command =~ /^raplite (.*)/ && $1
        Prolite::Sign.new.send_message("<PE><CB>   #{msg}   <FZ><A>")
        @muc.say("#{nick}: set raplite message to: #{msg}")
      }

      return true
    end

    def help_list(time, nick)
      return "raplite <message>"
    end

    def help(time, nick, command)
      return false unless command =~ /^raplite$/

      @muc.say("#{nick}: raplite <message>\nSets the raplite message")
      return true
    end

  end
end

