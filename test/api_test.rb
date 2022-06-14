require 'minitest/autorun'
require 'rack/test'

require './api'

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_unshort_e404
    get '/not_existing_short_code_url', { url: '/not_existing_short_code_url' }
    assert_equal 404, last_response.status, last_response.body
  end

  def test_sorten
    get '/shorten?url=foobar'
    assert_equal 200, last_response.status, last_response.body

    short = last_response.body
    assert short

    short = short.split('/')[-1]
    get "/#{short}"
    assert_equal 302, last_response.status, last_response.body
  end
end
