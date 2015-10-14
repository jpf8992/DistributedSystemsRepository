require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling

#Initialise thread pool using 'Pool' class 
numthreads = 10	#Specify # of threads to carry out operation
new_thread = Pool.new(numthreads)	#Thread Pool Constructor
puts "New Threadpool Created with  #{numthreads} threads\n"


#Create a new TCP Socket Server
portnumber = 2000
server = TCPServer.new (portnumber)
puts ("Server Created:  ")

#Loop until requested to terminate
#while ( soc = server.accept)
loop{	#server loops forever
#Test message
#puts "Server Running" 

	#soc = server.accept

	#Create a thread schedule block
	new_thread.schedule do  	#Schedule a new task
		#puts "Thread Started"
		while connection = server.accept
			while line = connection.gets
				if line == "KILL_SERVICE\n"
				puts line
				connection.puts "Kill Received"
				else 
				
				puts "No Kill"
				
				end
			end	
				connection.puts "Closing Connection"
				connection.close
		end
	end
	
	
	#puts "Thread Ended"
	#end
	#new_thread.shutdown
#end
	 
}

#at_exit { p.shutdown }
server.close
puts "Server is Closed..."

#while (insession = server.accept)
	
  #Thread.start(server.accept) do |client|
 # Thread.start do
  
	  #inform administrator of new connection
	#  puts "Received input from Client"
	  
	  #Retrieve message and output to terminal
	 # clientinput = insession.gets
	  #puts clientinput
  
	  #Send acknowledgment to client
	  #puts "closing connection with Client"
	  #insession.puts "Server: Farewell\n"
	  
  #end
#end





# Retrieve message and output to terminal
					# clientmessage = soc.gets
					# soc.puts clientmessage
					# puts clientmessage	#output to terminal
					
					# break if clientmessage == "KILL_SERVICE\n"
					
					
					# if clientmessage == "KILL_SERVICE\n"
						
						# puts "KILL MESSAGE WAS RECEIVED\n SERVER IS CLOSING..."
						# new_thread.shutdown #shut down threads gracefully
						# break