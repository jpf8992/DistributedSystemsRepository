require 'socket'

s = TCPSocket.new 'localhost', 2000


#Server can only read only iteration???
#2.times do |i|

#		s.puts "Message number: #{i} Sent\n"         # Send Message to server
#		puts "Client Sent: Message number: #{i} Sent\n" 
#		sleep rand(1) + 2

#		servermessage = s.gets
#		puts "Servers Response #{servermessage}"
#		end
		
		s.puts "KILL_SERVICE\n"		#Send a kill message
s.close             # close socket when done



