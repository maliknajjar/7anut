import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocket {
  WebSocket(){
    print("connection is established");
    var channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));

    channel.stream.listen((message) {
      // print(message);
      print("app listening for messages");
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
  }
}