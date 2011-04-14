# base class for all bot plugins
#

class BotPluginBase

  def initialize(muc, plugins)
    @muc = muc
    @plugins = plugins
  end

  def process(time, nick, command)
    puts "warning: undefined process()"
    return false
  end

  def help_list(time, nick)
    puts "warning: undefined help_list()"
    return nil
  end

  def help(time, nick, command)
    puts "warning: undefined help()"
    return false
  end

end
