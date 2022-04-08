CHAR = Array('a'..'z') + Array('0'..'9')
def generate_short_url
  Array.new(6) { CHAR.sample }.join
end

def shorten(base_url, url)
  short = generate_short_url
  storage_path = ENV['STORAGE_PATH']
  FileUtils.mkdir_p("#{storage_path}/#{short[0]}/#{short[1]}")
  File.write("#{storage_path}/#{short[0]}/#{short[1]}/#{short}", url)
  "#{base_url}/#{short}"
end

def unshorten(short)
  storage_path = ENV['STORAGE_PATH']
  File.read("#{storage_path}/#{short[0]}/#{short[1]}/#{short}")
rescue Errno::ENOENT
  nil
end
