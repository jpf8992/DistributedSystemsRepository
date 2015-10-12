require 'socket'

server = TCPServer.new (2000)
puts ("Server Started:  ")

while (insession = server.accept)
	
  #Thread.start(server.accept) do |client|
  Thread.start do
  
	  #inform administrator of new connection
	  puts "Received input from Client"
	  
	  #Retrieve message and output to terminal
	  clientinput = insession.gets
	  puts clientinput
  
	  #Send acknowledgment to client
	  puts "closing connection with Client"
	  insession.puts "Server: Farewell\n"
	  
  end
end