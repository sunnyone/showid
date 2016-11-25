#!/usr/bin/ruby

require 'sinatra'
require 'json'
require 'time'

set :bind, '0.0.0.0'
get '/hello' do
  content_type :json
  {
    status: "OK",
    time: Time.now.gmtime.iso8601
  }.to_json
end

get '/' do
  raise "/docker not not found in cgroup" unless File.read("/proc/1/cgroup") =~ %r|/docker/(.*)|
  id = $1

  content_type :json
  {
    id: id,
    time: Time.now.gmtime.iso8601
  }.to_json
end
