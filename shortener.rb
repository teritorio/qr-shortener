require 'digest'

def url_get_cache(url_hash)
  storage_path = ENV['STORAGE_PATH']
  File.read("#{storage_path}/url_cache/#{url_hash[0]}/#{url_hash[1]}/#{url_hash}")
rescue Errno::ENOENT
  nil
end

def url_set_cache(url_hash, short)
  storage_path = ENV['STORAGE_PATH']
  path = "#{storage_path}/url_cache/#{url_hash[0]}/#{url_hash[1]}"
  FileUtils.mkdir_p(path)
  File.write("#{path}/#{url_hash}", short)
end

CHAR = Array('a'..'z') + Array('0'..'9')
def generate_short_url(url)
  url_hash = Digest::SHA256.hexdigest(url)[-16..-1]
  short = url_get_cache(url_hash)
  if !short
    short = Array.new(6) { CHAR.sample }.join
    url_set_cache(url_hash, short)
  end
  short
end

def shorten(base_url, url)
  short = generate_short_url(url)
  storage_path = ENV['STORAGE_PATH']
  path = "#{storage_path}/short/#{short[0]}/#{short[1]}"
  FileUtils.mkdir_p(path)
  File.write("#{path}/#{short}", url)
  "#{base_url}/#{short}"
end

def unshorten(short)
  storage_path = ENV['STORAGE_PATH']
  File.read("#{storage_path}/short/#{short[0]}/#{short[1]}/#{short}")
rescue Errno::ENOENT
  nil
end
