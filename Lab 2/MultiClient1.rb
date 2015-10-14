require 'socket'

s = TCPSocket.new("localhost",2000)

	#Send message to server
	s.puts("KILL_SERVIC\n")
	puts "KILL_SERVIC\n"
	#sleep rand(5) + 2
	#Read message from server
	#servermessage = s.gets
	#puts "Servers Response #{servermessage}"
s.close             # close socket when done



