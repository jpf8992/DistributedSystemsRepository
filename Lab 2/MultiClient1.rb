require 'socket'

s = TCPSocket.new("localhost",2000)

	#Send message to server
	s.puts("HELO this a meessage\n")
	puts "Sent Message\n"
s.close             # close socket when done



