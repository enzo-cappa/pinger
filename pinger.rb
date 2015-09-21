#!/usr/bin/env ruby
require 'net/ping'
require 'pg'

conn = PGconn.connect("ip adddress", 5432, '', '', "db name", "user", "password")
conn.prepare('statement1', "INSERT INTO games (game_hash,team1,team2,team1score,team2score,time,update_at) VALUES ($1,$2,$3,$4,$5,$6,$7)");
def save_result  
  conn.exec_prepared('statement1', [myId, team1, team1score, team2, team2score, progress, update]);
  res  = conn.exec('select tablename, tableowner from pg_tables')
  res.each do |row|
    puts row['tablename'] + ' | ' + row['tableowner']
  end
end

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