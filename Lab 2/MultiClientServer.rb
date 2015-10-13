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
#while ( insession = server.accept)
loop{	#server loops forever
#Test message
puts "Server Running" 

	#Create a thread schedule block
	new_thread.schedule(server.accept) do |client| 	#Schedule a new task

	#Retrieve message and output to terminal
	clientmessage = client.gets
	client.puts clientmessage
	puts clientmessage	#output to terminal
	
		 if clientmessage == "KILL_SERVICE\n"
			 puts "KILL MESSAGE WAS RECEIVED\n SERVER IS CLOSING..."
			 server.close
			 break
		 end 
	
	end
	 
}

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