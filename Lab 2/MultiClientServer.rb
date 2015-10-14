

require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling

# class Pool
# def initialize(size)
# @size = size
# @jobs = Queue.new
# @pool = Array.new(@size) do |i|
      # Thread.new do
        # Thread.current[:id] = i
# catch(:exit) do
# loop do
# job, args = @jobs.pop
            # job.call(*args)
          # end
        # end
      # end
    # end
  # end
  # def schedule(*args, &block)
  # @jobs << [block, args]
  # end
  # def shutdown
  # @size.times do
      # schedule { throw :exit }
    # end
  # @pool.map(&:join)
  # end
# end
  

#Initialise thread pool using 'Pool' class 
numthreads = 10	#Specify # of threads to carry out operation
new_pool = Pool.new(numthreads)	#Thread Pool Constructor
puts "New Threadpool Created with  #{numthreads} threads\n"


#Create a new TCP Socket Server
portnumber = 2000
server = TCPServer.new (portnumber)
puts ("Server Created:  ")

loop do	 #server loops forever
	connect = server.accept
	line = connect.gets
	#Create a thread schedule block
	puts connect.gets
	new_pool.schedule do  	#Schedule a new task to a thread
		#puts "In Thread"

		if line == "KILL_SERVICE\n"					#line.include		#message contained in string
			#connect.puts "Kill_Received"
			#puts line
			abort("Server Aborted - Connections Forced Closed")	#Shut down server
		else 
			puts "No Kill"	
		end
	end
	#close connection with client 
	#sleep(3)	#Prevent race conditions
	connect.close
	puts "Connection Closed"
end

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



