require 'sinatra'
require 'sinatra/reloader'
require 'simple-rss'
require 'open-uri'
 
get '/' do
  urls = %w(
    http://mizchi.hatenablog.com/rss http://d.hatena.ne.jp/gamella/rss
  )
  @que = Queue.new
  urls.map{|url| @que << url}
  erb :index
end

get '/it' do
  urls = %w(
    http://blog.livedoor.jp/itsoku/index.rdf http://jsksokuhou.com/feed/
  )
  @que = Queue.new
  urls.map{|url| @que << url}
  erb :index
end