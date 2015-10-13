require 'socket'

s = TCPSocket.new 'localhost', 2000

s.puts "KILL_SERVICE\n"         # Send Message to server

s.close             # close socket when done