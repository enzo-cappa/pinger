#!/usr/bin/env ruby
require 'net/ping'

@icmp = Net::Ping::ICMP.new('google.com')
rtary = []
pingfails = 0
repeat = 5
puts 'starting to ping'
while true do
	if @icmp.ping
		rtary << @icmp.duration
		puts "host replied in #{@icmp.duration}"
	else
		pingfails += 1
		puts "timeout"
	end
	sleep 5
end
avg = rtary.inject(0) {|sum, i| sum + i}/(repeat - pingfails)
puts "Average round-trip is #{avg}\n"
puts "#{pingfails} packets were droped"