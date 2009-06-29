# base class for all bot plugins
#

class BotPluginBase

  def initialize(muc)
    @muc = muc
  end

  def process(time, nick, command)
    puts "warning: undefined process()"
    return false
  end
end
