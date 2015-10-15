require 'socket'

s = TCPSocket.new("localhost",2000)

	#Send message to server
	s.puts("HLO this a meessage\n")
	puts "KILL_SERVICE\n"
	#sleep rand(5) + 2
	#Read message from server
	#servermessage = s.gets
	#puts "Servers Response #{servermessage}"
s.close             # close socket when done



