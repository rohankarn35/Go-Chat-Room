import 'dart:convert';
import 'package:gorandom/core/app_secrets.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/utils/randomId.dart';
import 'package:http/http.dart' as http;

class Createroom {
  var random = Randomid();

  Future<String> createRoom(
      {required String roomName, required String username}) async {
    String roomId = random.randomId();
    final APIURL = "${AppSecrets.createRoomApi}$roomId/$roomName";

    try {
      final response = await http.get(Uri.parse(APIURL));

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        ToastMessage.toastMessage(
            toastMessage: "Room Created", message: 'Chat and Share');
        // print(res["roomId"]);
        return res["roomId"];
      } else {
        throw Exception(ToastMessage.toastMessage(
            toastMessage: "Failed to Create Room",
            isSucess: false,
            message: 'Try Again'));
      }
    } catch (e) {
      ToastMessage.toastMessage(
          toastMessage: "Error while creating Room",
          isSucess: false,
          message: 'Check your internet connection and try again');
      return "";
    }
  }
}
