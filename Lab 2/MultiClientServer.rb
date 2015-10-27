require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling. Copyright © 2012, Kim Burgestrand
require_relative 'SocketString'


#Initialise thread pool using 'Pool' class 
numthreads = 10	#Specify # of threads to carry out operation
new_pool = Pool.new(numthreads)	#Thread Pool Constructor
puts "New Threadpool Created with  #{numthreads} threads\n"

portnumber = ARGV.first	#Take in port number from start <port number> in batch file
puts "Portnumber: #{portnumber} " 
Integer(portnumber)	#Convert to int

#Create a new TCP Socket Server
#portnumber = 8000
#hostname = "134.226.32.10"
hostname = "localhost"

server = TCPServer.new(hostname,portnumber)
puts ("Server Created:  ")

addr_infos = Socket.ip_address_list	#IP address to return to client

#puts "Address infos:   #{addr_infos[2]}"

ip = IPSocket.getaddress(Socket.gethostname)
    #puts ip 
StudentID = "7978aa6f13ccec45a0d2f2ab6929b607369312d75d7681d833f269172e89313f"

loop do	 #server loops forever
	connect = server.accept
	line = connect.gets
	puts connect.gets
	#Create a thread schedule block
	new_pool.schedule do  	#Schedule a new task to a thread
		if line == "KILL_SERVICE\n"					
			abort("Server Aborted - Connections Forced Closed \n")	#Shut down server
		elsif line.initial ==  "HELO"		#True only if the first four letters are 'HELO' (which are isolated by the .initial from SocketString Class) 
			#connect.puts "#{line}"+"IP:"+"#{ip}"+"Port:#{portnumber}"+"StudentID:#{StudentID}"
			connect.print "HELO text\n"
			connect.print "IP:[ip address]\n"
			connect.print "Port:[port number]\n"
			connect.print "StudentID:[your student ID]\n"
			
		else 
				puts "Message Not Processed?? \n"
		end
	end
	#close connection with client 
	connect.close
	puts "Connection Closed \n Awaiting New Client..."
end

server.close
puts "Server is Closed..."
