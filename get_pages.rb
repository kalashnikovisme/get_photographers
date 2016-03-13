require 'net/http'

def uniq?(lines, line)
  name = line.split("<a href=\"/photographer/")[1]
  return false unless name
  name = name.split('/')[0]
  lines.each do |l|
    return false if l.include? name
  end
end

lines = []
10.times do |page|
  page += 2
  File.foreach("index#{page}.html") { |line| lines << line if line.include?("/photographer/") && uniq?(lines, line) }
 
#  source = Net::HTTP.get 'www.mywed.ru', "/photographers/p#{page}"
#  File.write "index#{page}.html", source
#  print "#{page}\r"
end
lines.each do |line|
  name = line.split("<a href=\"/photographer/")[1].split('/')[0]
  File.open 'names.txt', 'a' do |f|
    f << "#{name}\n"
  end
end
puts 'Done!'
