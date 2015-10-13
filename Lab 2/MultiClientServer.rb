require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling

#Initialise thread pool using 'Pool' class 
threads = 10	#Specify # of threads to carry out operation
new_pool = Pool.new(threads)	#Thread Pool Constructor
puts "New Threadpool Created with  #{threads} threads\n"


#Create a new TCP Socket Server
portnumber = 2000
server = TCPServer.new (portnumber)
puts ("Server Created:  ")

#Loop until requested to terminate
while ( insession = server.accept)
#Test message
puts "Server Looping" 

	#Retrieve message and output to terminal
	 clientinput = insession.gets
	 
	 if clientinput == "KILL_SERVICE\n"
	 puts "KILL MESSAGE WAS RECEIVED\n"
	 break
	 end
	 
end

puts "Server is Closing..."
server.close
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