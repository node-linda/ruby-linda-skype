#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'skype'
require 'linda-socket.io-client'
$stdout.sync = true

ENV['LINDA_BASE']  ||= 'http://node-linda-base.herokuapp.com'
ENV['LINDA_SPACE'] ||= 'test'
ENV["CHAT_TOPIC"]  ||= 'linda'

chat = Skype.chats.find{|c| c.topic =~ /#{ENV['CHAT_TOPIC']}/ }

unless chat
  STDERR.puts "chat not found topic matches /#{ENV['CHAT_TOPIC']}/"
  exit 1
end

puts "chat id:#{chat.id}  topic:#{chat.topic}"

linda = Linda::SocketIO::Client.connect ENV['LINDA_BASE']
ts = linda.tuplespace(ENV['LINDA_SPACE'])

linda.io.on :connect do
  puts "connect!!"
  puts "watching {type: 'skype', cmd: 'post'} in tuplespace #{ts.name}"
  puts " => #{linda.url}/#{ts.name}?type=skype&cmd=post&value=hello"

  ts.watch type: "skype", cmd: "post" do |err, tuple|
    p tuple
    next if tuple.data.response
    str = tuple.data.value.to_s
    next if str.empty?
    msg = "(ninja) 《Linda》 #{str} 《#{ts.name}》"
    chat.post msg
    ts.write type: "skype", cmd: "post", value: str, response: "success"
  end

end

linda.io.on :disconnect do
  puts "socket.io disconnect"
end

loop do
  sleep 1
end

