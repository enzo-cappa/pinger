#!/usr/bin/env ruby
require 'net/ping'
require 'sqlite3'

@db = SQLite3::Database.new 'pinger'
@db.execute "CREATE TABLE IF NOT EXISTS ping(ping_date INTEGER PRIMARY KEY, ping_result INTEGER, ping_duration INTEGER)"

def save_result(ping_date, ping_result, ping_duration)
  @db.execute("INSERT INTO ping(ping_date, ping_result, ping_duration) VALUES (?,?,?)", ping_date, ping_result, ping_duration )
end

@icmp = Net::Ping::ICMP.new('google.com')
puts 'starting to ping'
while true do
  ping_date = Time.now.getutc.to_i
  ping_result = 0
  ping_duration = -1
  if @icmp.ping
    ping_duration = @icmp.duration
    ping_result = 1
    puts "host replied in #{@icmp.duration}"
  end  
  save_result(ping_date, ping_result, ping_duration)
  sleep 5
end