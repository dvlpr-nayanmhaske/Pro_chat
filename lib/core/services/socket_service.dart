import 'package:commet_chat/core/services/tokens.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  final String host = "http://localhost:3000";

  void connect() {
    socket = IO.io(
      host,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setAuth({'token': Tokens.accessToken})
          .setReconnectionAttempts(5)
          .setReconnectionDelay(1000)
          .build(),
    );

    // FUNCTION TO CONNECT SOCKET
    socket.connect();

    socket.onConnect((_) {
      print("SOCKET CONNECTED SUCCESSFULLY");

      // TO DO AFTER CONNECTED TO SOCKET
    });

    socket.onDisconnect((_) {
      print("Socket Discconcted");
    });

    socket.onError((error) {
      print(error);
    });
  }

  void listenEvent(event, onData) {
    socket.on(event, (data) {
      onData(data);
    });
  }

  void stopListening(event) {
    socket.off(event);
  }

  void disconnect() {
    socket.disconnect();
  }
}
