require 'bot_plugin_base'

module BotPlugin
  class HelpPlugin < BotPluginBase
    def initialize(muc, plugins)
      super(muc, plugins)
    end

    def process(time, nick, command)
      return false unless (command =~ /^help$/ or command =~ /^help /)

      if command =~ /^help$/
        # we want a listing
        helps = []
        @plugins.each { |p|
          helps << p.help_list(time, nick)
        }
        @muc.say("#{nick}: #{helps.compact.join("\n")}")
      elsif msg = command =~ /^help (.*)/ && $1
        # we want a specific help
        found=false
        @plugins.each { |p|
          if (p.help(time, nick, msg) == true)
            found=true
            break
          else
            next
          end

          @muc.say("#{nick}: no such command") unless found
        }
      else
        return false
      end

      return true
    end

    def help_list(time, nick)
      return "help [topic]"
    end

    def help(time, nick, command)
      return false unless command =~ /^help$/

      @muc.say("#{nick}: help [topic]\nGet information on bot commands.")
      return true
    end

  end
end

