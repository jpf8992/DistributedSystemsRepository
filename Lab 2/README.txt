README

Server Created in Ruby:
ruby -v
... 2.0.0p647

Setting the ruby.exe into the environments variables path 
may be necessary to run the start.bat <port_number> from 
the command line.  

Note, the threadpool functionality was achieved through the use of code found at:
http://www.burgestrand.se/code/ruby-thread-pool/

Files in the lab 2 folder:

MultiClient1.rb - 
Used to test the server by establishing a socket under a given port.


MultiClientServer.rb -
Holds the ruby code to establish the thread pooled server. once executed,
the server runs in a continuous loop and awaits clients.

sample_thread_pool.rb - 
Hold the Pool Class that is essential for implementing thread pooling.

SocketString.rb - 
Not necessarily essential, but offers a method to extract the first
four characters from the incoming string to the server to determine if
they match 'HELO'.

start - 
Batch file used to start the server with a user defined port.
The command "start.bat 2000" should be typed in the command line 
of the stored directroy to automatically set up the MultiClientServer
with a port number of 2000. 
Note: that the choice of 2000 in this example is arbitrary. 


Procedure:
Type..."start.bat 2000"... into command line of stored directroy
	-> server should start up, and provide a visual indication to terminal
	
		-> the server should now be awaiting clients
		
		

	