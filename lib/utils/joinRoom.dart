import 'dart:convert';

import 'package:gorandom/core/app_secrets.dart';
import 'package:gorandom/utils/GetRoomId.dart';
import 'package:gorandom/utils/checkString.dart';
import 'package:http/http.dart' as http;

class Joinroom {
  Future<Map<String, dynamic>> joinRoom(String input) async {
    try {
      String? roomId;

      if (IsString.isValidUrl(input)) {
        roomId = GetRoomId().getRoomId(input);

        if (roomId == "") {
          return _response("URL Error", false, "", '');
        }
      } else {
        roomId = input;
      }
      final APIURL = "${AppSecrets.joinUrl}$roomId";

      bool isValidRoom;
      print(APIURL);
      // final response = await http.get(Uri.parse(APIURL));
      final response = await http.get(
        Uri.parse(APIURL),
      );

      if (response.statusCode == 202) {
        isValidRoom = true;
      } else {
        isValidRoom = false;
      }

      if (isValidRoom) {
        final res = json.decode(response.body);
        final roomName = res["roomName"];
        return _response("Connection Successfull", true, roomName, roomId!);
      } else {
        return _response("Room not found", false, "", '');
      }
    } catch (e) {
      print(e);
      return _response("Something went wrong", false, "", "");
    }
  }

  Map<String, dynamic> _response(
      String message, bool status, String roomName, String roomId) {
    return {
      "message": message,
      "status": status,
      "roomName": roomName,
      "roomId": roomId
    };
  }
}
