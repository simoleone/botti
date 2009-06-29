#!/usr/bin/ruby

# bot-specific stuff
require 'config'

# gems
require 'rubygems'
require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'

$LOADED_PLUGINS = []

# connect and authenticate with the server
client = Jabber::Client.new(Jabber::JID::new($botJID))
client.connect
client.auth($password)
muc = Jabber::MUC::SimpleMUCClient.new(client)

# load up all the modules
$PLUGINS.each { |m|
  require "plugins/#{m}"
}
BotPlugin.constants.each { |m|
  mod = BotPlugin.const_get(m)
  if (mod < BotPluginBase)
    $LOADED_PLUGINS << mod.new(muc)
  end
}

# set up callbacks
muc.on_message { |time,nick,text|
  next unless text =~ /^#{$botName}: /i

  command = text =~ /^#{$botName}: (.*)/i && $1
  command = command.strip
   
  found=false
  $LOADED_PLUGINS.each { |p|
    if (p.process(time, nick, command) == true)
      found=true
      break
    else
      next
    end
  }
  muc.say("unrecognized command. \"help\" for a list.") unless found
}


# join the room
muc.join(Jabber::JID.new($roomJID))

# just chill until killed
#
begin
  while true do
    sleep(1)
  end
  rescue Interrupt => e
    muc.exit
    client.close
end

