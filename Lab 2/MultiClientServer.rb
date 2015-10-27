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
hostname = "134.226.32.10"		#IP of MacNeill Machine - Needed this to test the code!!
#hostname = "134.226.50.185"
#hostname = "localhost"

server = TCPServer.new(hostname,portnumber)
puts ("Server Created:  ")

#Store IP address to output later
ip = IPSocket.getaddress(Socket.gethostname)
    
StudentID = "7978aa6f13ccec45a0d2f2ab6929b607369312d75d7681d833f269172e89313f"

	loop do	 #server loops forever
		#puts "In Loop"
		connect = server.accept
		
		#Create a thread schedule block
		new_pool.schedule do  	#Schedule a new task to a thread
		
			message = connect.gets
			puts message
			
			#connect.puts "In Thread\n"
			if message.include?"KILL_SERVICE"		

					puts "Kill received"
						abort("Server Aborted - Connections Forced Closed ")	#Shut down server
			elsif	message.initial ==  "HELO"		#True only if the first four letters are 'HELO' (which are isolated by the .initial from SocketString Class) 
						
						connect.puts "#{message}"+"IP:"+"#{hostname}\n"+"Port:#{portnumber}\n"+"StudentID:#{StudentID}\n"
												
			else 
						puts "Message Not Processed?? \n"
			end
			
			connect.close
			puts "Connection Closed \n Awaiting New Client..."
			end
		
		
		puts "Connection Closed \n Awaiting New Client..."
	end

#server.close
puts "Server is Closed..."
