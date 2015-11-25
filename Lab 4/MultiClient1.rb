require 'socket'

s = TCPSocket.new("localhost",8000)


#JOIN_CHATROOM: [chatroom name]
#CLIENT_IP: [IP Address of client if UDP | 0 if TCP]
#PORT: [port number of client if UDP | 0 if TCP]
#CLIENT_NAME: [string Handle to identifier client user]


	#Send message to server
	#s.puts("HELO this a meessage\n")
	#sleep 5
	#puts "Sent Message\n"
	
	line = s.gets   # Read lines from the socket
	puts line     # And print with platform line terminator
#end


s.close             # close socket when done



