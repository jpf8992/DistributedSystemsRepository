require 'socket'

s = TCPSocket.new 'localhost', 2000


#Server can only read only iteration???
#1.times do |i|

		# s.puts "Message number: #{i} Sent\n"         # Send Message to server
		# puts "Client Sent: Message number: #{i} Sent\n" 
		# sleep rand(5) + 2

		# servermessage = s.gets
		# puts "Servers Response #{servermessage}"
		# end
		
		#s.puts "KILL_SERVICE\n"		#Send a kill message
		
		s.puts "KILL_SERVICE\n"         # Send Message to server
		puts "Client Sent: KILL_SERVICE\n" 
		sleep rand(5) + 2

		servermessage = s.gets
		puts "Servers Response #{servermessage}"
s.close             # close socket when done



