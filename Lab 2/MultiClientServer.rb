require 'socket'

server = TCPServer.new (2000)
puts ("Server Started:  ")
loop do
while (insession = server.accept)
	
  Thread.start(server.accept) do |client|
    client.puts "Hello !"
    client.puts "Time is #{Time.now}"
    client.close
  end
end