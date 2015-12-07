		connections = Hash.new
		rooms = Hash.new
		clients = Hash.new
		connections[:server] = @server
		connections[:rooms] = @rooms
		connections[:clients] = @clients

connections[:rooms] = rooms
connections[:clients] = clients

room_ref = 101
client_id = 1
connections[:rooms][client_id] = room_ref
puts connections



room_ref = 101
client_id = 2
connections[:rooms][client_id] = room_ref
puts connections



connections[:rooms].each do |client,room_name|
	puts client
end
