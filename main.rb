require 'sinatra'
require 'sinatra/reloader'
require 'simple-rss'
require 'open-uri'

get '/' do
  urls = %w(
    http://mizchi.hatenablog.com/rss
    http://d.hatena.ne.jp/gamella/rss
  )
  parse(urls)
  erb :index
end

get '/it' do
  urls = %w(
    http://blog.livedoor.jp/itsoku/index.rdf
    http://jsksokuhou.com/feed/
  )
  parse(urls)
  erb :index
end

def parse(urls)
  @articles = []
  urls.map do |url|
    rss = SimpleRSS.parse open(url)
    rss.items.each do |entry|
      @articles << [entry.title.force_encoding('utf-8'),entry.link]
    end
  end
end
