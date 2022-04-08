require 'sinatra'

require './shortener'
require './qrcode'

get '/:short' do
  url = unshorten(params[:short])
  if url.nil?
    404
  else
    redirect url
  end
end

get %r{/shorten/.*} do
  # REQUEST_URI
  url = request.env['REQUEST_PATH'][('/shorten/'.size)..-1]
  shorten(ENV['URL_BASE'], url) if url && url.size < 1024
end

get %r{/qrcode.svg/.*} do
  url = request.env['REQUEST_PATH'][('/shorten/'.size)..-1]
  if url && url.size < 1024
    url = shorten(ENV['URL_BASE'], url)

    content_type 'image/svg+xml'
    qrcode(url)
  end
end
