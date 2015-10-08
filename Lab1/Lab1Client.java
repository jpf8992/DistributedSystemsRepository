import java.io.*;
import java.net.*;
class TCPClient{
 public static void main(String argv[]) throws
Exception {
 String modifiedSentence;
 Socket clientSocket = new Socket("127.0.0.1",8000);
 
 Console c = System.console();
        if (c == null) {
            System.err.println("No console.");
            System.exit(1);
        }
 
 //Ask user for input
 System.out.println( "**Beginning Simulation**");
 String TestWord = c.readLine("Enter your Test Word: ");
 
 //Create a object to handle message for bufferstream
 PrintWriter printw = new PrintWriter(clientSocket.getOutputStream());
 printw.println("GET /echo.php?message="+ TestWord + "HTTP/1.0\r\n");
 printw.flush();	//send user defined message
 BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));	//handle incoming comms. from server
 
 //Read all messages from server and then terminate connection
 while((modifiedSentence = inFromServer.readLine()) != null)
 {
  System.out.println("SERVER Message: " + modifiedSentence);
 }
 inFromServer.close();
 clientSocket.close();
 }
}