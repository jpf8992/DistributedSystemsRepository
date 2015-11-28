require 'socket'
require 'thread'
require_relative 'sample_thread_pool'		#This contains the pool class as required to implement thread pooling. Copyright © 2012, Kim Burgestrand
require_relative 'SocketString'

$studentID = "7978aa6f13ccec45a0d2f2ab6929b607369312d75d7681d833f269172e89313f"
		

class Server


	def initialize( port, ip)
		@server = TCPServer.open( ip, port )
		@connections = Hash.new
		@rooms = Hash.new
		@clients = Hash.new
		@connections[:server] = @server
		@connections[:rooms] = @rooms
		@connections[:clients] = @clients
		run
	  end


	def run
		
		
		
		puts "Server Started"
		puts $studentID
		#Initialise thread pool using 'Pool' class 
		#numthreads = 10	#Specify # of threads to carry out operation
		#new_pool = Pool.new(numthreads)	#Thread Pool Constructor
		#puts "New Threadpool Created with  #{numthreads} threads\n"

		#portnumber = ARGV.first	#Take in port number from start <port number> in batch file
		port = 8090
		#puts "Portnumber: #{portnumber} " 
		#Integer(portnumber)	#Convert to int

		#Create a new TCP Socket Server
		hostname = "134.226.32.10"		#IP of MacNeill Machine - Needed this to test the code!!
		#hostname = "134.226.50.185"
		#hostname = "localhost"

		#server = TCPServer.new(hostname,portnumber)
		#puts ("Server Created:  ")

		#Store IP address to output later
		#ip = IPSocket.getaddress(Socket.gethostname)
			
		
		#StudentID = "7978aa6f13ccec45a0d2f2ab6929b607369312d75d7681d833f269172e89313f"

			loop{	 #server loops forever
				
				puts "In Loop"
				Thread.start(@server.accept) do | client |
				
					message = client.gets
					puts message
					
					if message.include?"KILL_SERVICE"		
						puts "Kill received"
						abort("Server Aborted - Connections Forced Closed ")	#Shut down server
					elsif	message.initial ==  "HELO"		
						
						puts port
						client.puts "#{message}"+"IP:"+"#{hostname}\n"+"Port:#{port}\n"+"StudentID:#{$studentID}\n"
					elsif	message.include?"JOIN_CHATROOM" 	#Join Request
							
						#puts message
						puts "xxx"	
						#ENSURE THAT YOU ONLY EXTRACT THE RELEVANT DETAILS FROM MESSAGE!!!!
						#Process Join Request	
						chatName = message[14...-1]		#First Line - JOIN_CHATROOM: [chatroom name]
						message = client.gets
						clientIP = message[10...-1] 		#Second Line - CLIENT_IP: [IP Address of client if UDP | 0 if TCP]
						message = client.gets
						portNum = message[5...-1] 		#Third Line - PORT: [port number of client if UDP | 0 if TCP]
						message = client.gets
						clientName = message[12...-1] 	#Fourth Line - CLIENT_NAME: [string Handle to identifier client user]
						
						#Check the values assigned to variables
						#puts ChatName 
						#puts ClientIP
						#puts PortNum
						#puts ClientName
						
						#Send Message Confirmation to Client
						client.puts "JOINED_CHATROOM:"+"#{chatName}"+"\n"
						client.puts "SERVER_IP:"+ "#{hostname}" + "\n"
						client.puts "PORT:"+ "#{port}" + "\n"
						client.puts "ROOM_REF:"+ "#{123}" + "\n"
						client.puts "JOIN_ID:"+ "#{321}" + "\n"
						
						#Indicate Client has joined Chatroom
						@connections[:clients].each do |other_name, other_client|
						  if clientName == other_name || client == other_client
							client.puts "This username already exist"
							Thread.kill self
						  end
						end
						
						puts "#{clientName} #{client}"
						@connections[:clients][clientName] = client
						client.puts "CHAT:d"
						listen_user_messages( clientName, client )
					else
					
						puts "Message Not Processed?? \n"
						#puts message
						#client.puts "JOINED_CHATROOM: \n"
					end
							
				client.close
				puts "Connection Closed \n Awaiting New Client..."
						
				end	
				
			}.join
	end
	
	def listen_user_messages( username, client )
		loop {
		  msg = client.gets.chomp
		  @connections[:clients].each do |other_name, other_client|
			unless other_name == username
			  other_client.puts "#{username.to_s}: #{msg}"
			end
		  end
		}
	end
	
end


Server.new( 8090, "134.226.32.10" )