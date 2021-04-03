import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class TheWebSocket {
  static void connect(){
    var channel = WebSocketChannel.connect(Uri.parse('wss://7anut.app'));
    print("connection established");
    channel.sink.add('hello server');
    channel.stream.listen((message) {
      print(message);
      channel.sink.close(status.goingAway);
    }, onDone: (){
      print("connection is closed");
    }, onError: (error) {
      print("there was an error");
    });
  }
}