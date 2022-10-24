require 'sinatra'
require 'sinatra/reloader'
require 'rss'

get '/' do
  urls = %w(
    https://www.soumu.go.jp/news.rdf
    http://www.gsi.go.jp/index.rdf
  )
  parse(urls)
  erb :index
end

get '/it' do
  urls = %w(
    https://www.jnsa.org/rss.xml
    http://canon-its.jp/eset/malware_info/rss/release.xml
  )
  parse(urls)
  erb :index
end

def parse(urls)
  @articles = []
  
  urls.map do |url|
    rss = nil
    begin
      rss = RSS::Parser.parse(url)
    rescue RSS::InvalidRSSError
      rss = RSS::Parser.parse(url,false)
    end
    
    rss.items.each do |entry|
      @articles << [entry.title.force_encoding('utf-8'),entry.link]
    end
  end
end
