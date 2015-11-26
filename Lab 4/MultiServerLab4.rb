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
			#puts message
			
			#connect.puts "In Thread\n"
			if message.include?"KILL_SERVICE"		

					puts "Kill received"
						abort("Server Aborted - Connections Forced Closed ")	#Shut down server
			elsif	message.initial ==  "HELO"		#True only if the first four letters are 'HELO' (which are isolated by the .initial from SocketString Class) 
						
						connect.puts "#{message}"+"IP:"+"#{hostname}\n"+"Port:#{portnumber}\n"+"StudentID:#{StudentID}\n"
												
			elsif	message.include?"JOIN_CHATROOM" 	#Join Request
					
					puts message
					
					
					
					#ENSURE THAT YOU ONLY EXTRACT THE RELEVANT DETAILS FROM MESSAGE!!!!
					#Process Join Request	
					ChatName = message		#First Line - JOIN_CHATROOM: [chatroom name]
					message = connect.gets
					
					puts message
					
					ClientIP = message 		#Second Line - CLIENT_IP: [IP Address of client if UDP | 0 if TCP]
					message = connect.gets
					PortNum = message 		#Third Line - PORT: [port number of client if UDP | 0 if TCP]
					message = connect.gets
					ClientName = message 	#Fourth Line - CLIENT_NAME: [string Handle to identifier client user]
					blank = connect.gets
					
					#Check the values assigned to variables
					puts ChatName 
					puts ClientIP
					puts PortNum
					puts ClientName
					puts blank
					
					
					#Send Message Confirmation to Client
					connect.puts "JOINED_CHATROOM: ["+"#{ChatName}"+"]\n"
					connect.puts "SERVER_IP: ["+ "#{hostname}" + "]\n"
					connect.puts "PORT: ["+ "#{portnumber}" + "]\n"
					connect.puts "ROOM_REF: ["+ "#{123}" + "]\n"
					connect.puts "JOIN_ID: ["+ "#{321}" + "]\n"
					
					#JOINED_CHATROOM: [chatroom name]
					#SERVER_IP: [IP address of chat room]
					#PORT: [port number of chat room]
					#ROOM_REF: [integer that uniquely identifies chat room on server]
					#JOIN_ID: [integer that uniquely identifies client joining]
										
					
			else
			
					puts "Message Not Processed?? \n"
					#puts message
					#connect.puts "JOINED_CHATROOM: \n"
			end
			
			
			connect.close
			puts "Connection Closed \n Awaiting New Client..."
			end
		
		
		puts "Connection Closed \n Awaiting New Client..."
	end

#server.close
puts "Server is Closed..."
