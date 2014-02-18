require 'socket'

server = TCPServer.new 1666 # Server bound to port 1666

loop do
  client = server.accept
  request = client.gets
  verb, path, header = request.split(' ')

  path = File.join("public", path)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts "Content-Length: "
  client.puts "Connection: close"
  client.puts
  
  File.open(path, "r") do |file|
    client.puts file.read
  end

  client.close
end
