require 'bot_plugin_base'
require '/tc/svn/admin/trunk/include/raplite/lib/prolite'

module BotPlugin
  class RaplitePlugin < BotPluginBase
    def initialize(muc)
      super(muc)
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
  end
end

