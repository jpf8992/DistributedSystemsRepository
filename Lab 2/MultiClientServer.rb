

require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling Copyright © 2012, Kim Burgestrand
require_relative 'SocketString'

#Initialise thread pool using 'Pool' class 
numthreads = 10	#Specify # of threads to carry out operation
new_pool = Pool.new(numthreads)	#Thread Pool Constructor
puts "New Threadpool Created with  #{numthreads} threads\n"

portnumber = ARGV.first	#Take in port number from start <port number> batch file
#puts "Protnumber: #{portnumber}"
Integer(portnumber)	#Convert to int

#Create a new TCP Socket Server
#portnumber = 2000
server = TCPServer.new (portnumber)
puts ("Server Created:  ")


addr_infos = Socket.ip_address_list	#IP address to return to client

loop do	 #server loops forever
	connect = server.accept
	line = connect.gets
	#Create a thread schedule block
	puts connect.gets
	new_pool.schedule do  	#Schedule a new task to a thread
		#puts "In Thread"

		if line == "KILL_SERVICE\n"					#line.include		#message contained in string
			abort("Server Aborted - Connections Forced Closed")	#Shut down server
		elsif line.initial ==  "HELO"		#True only if the first four letters (which are isolated by the .initial from SocketString Class) are 'HELO'
			puts "#{line}\n" + "IP:" + "#{addr_infos}\n" +"Port: #{portnumber}\n" 	+ "StudentID:7978aa6f13ccec45a0d2f2ab6929b607369312d75d7681d833f269172e89313f\n"
		else 
				puts "Message Not Processed??"
		end
	end
	#close connection with client 
	connect.close
	puts "Connection Closed \n Awaiting New Client..."
end

server.close
puts "Server is Closed..."
