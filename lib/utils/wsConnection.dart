import 'package:gorandom/core/app_secrets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Wsconnection {
  Map<String, dynamic> wsConnection(String roomId) {
    try {
      final APIURL = "${AppSecrets.wsRoomApi}$roomId";
      final WebSocketChannel channel =
          WebSocketChannel.connect(Uri.parse(APIURL));
      return {'channel': channel, 'error': null};
    } catch (e) {
      print(e);
      return {'channel': null, 'error': e.toString()};
    }
  }
}
