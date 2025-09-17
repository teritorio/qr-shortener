require 'sinatra'

require './shortener'
require './qrcode'

get '/' do
  204
end

get '/up' do
  204
end

get '/shorten' do
  url = params[:url]
  shorten(ENV['URL_BASE'], url) if url && url.size < 1024
end

get '/qrcode.svg' do
  url = params[:url]
  if url && url.size < 1024
    url = shorten(ENV['URL_BASE'], url)

    content_type 'image/svg+xml'
    qrcode(url)
  end
end

get '/:short' do
  url = unshorten(params[:short])
  if url.nil?
    404
  else
    redirect url
  end
end
