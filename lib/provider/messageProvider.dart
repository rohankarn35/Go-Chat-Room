import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/utils/wsConnection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Messageprovider with ChangeNotifier {
  bool _isHovered = false;
  bool get isHovered => _isHovered;

  WebSocketChannel? channel;
  List<Map<String, dynamic>> _messages = [];
  String userCount = "";

  List<Map<String, dynamic>> get messages => _messages;
  bool hasConnection = true;

  void isHover(bool value) {
    _isHovered = value;
    notifyListeners();
  }

  String roomName = "Chat Room";
  getRoomName(String roomname) {
    roomName = roomname;
    notifyListeners();
  }

  clearMessage() {
    _messages.clear();
  }

  void webSocketConnection(String id) {
    try {
      Map<String, dynamic> res = Wsconnection().wsConnection(id);
      if (res["channel"] != null) {
        if (res["error"] == null) {
          channel = res["channel"];

          channel!.stream.listen((message) {
            final parsedMessage = parseMessage(message);
            final username = parseUsername(message);

            if (parsedMessage != null) {
              _messages.insert(0,
                  {'text': parsedMessage, 'isMe': false, "username": username});
              notifyListeners();
            }
          }, onDone: () {
            ToastMessage.toastMessage(
                toastMessage: "Connection Ended",
                message:
                    "If not ended by you, there might be the issue with with connection",
                isSucess: true);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => Roomoptions(),
            //     ));
            // ToastMessage.toastMessage(
            //     toastMessage: "The connection has ended", isSucess: true);
            // notifyListeners();
          }, onError: (value) {
            print("error ${value.hashCode}");
          });
        } else {
          channel = null;
          ToastMessage.toastMessage(
              toastMessage: "Server Error",
              isSucess: false,
              message: 'Something went wrong from our side');
        }
      } else {
        print("null channel");
      }
    } catch (e) {
      ToastMessage.toastMessage(
          toastMessage: "Could not establish connection",
          isSucess: false,
          message: 'Issue with internet');
    }
  }

  void sendMessage(String text, String username) {
    if (channel != null && text.isNotEmpty) {
      try {
        final message = jsonEncode({
          "username": username,
          'content': text,
        });
        // Add message to the list with a temporary flag
        _messages.insert(0, {
          'text': text,
          'isMe': true,
          'tempId': DateTime.now().millisecondsSinceEpoch.toString(),
          'username': ""
        });
        notifyListeners();
        // Send the message
        channel!.sink.add(message);
      } catch (e) {
        ToastMessage.toastMessage(
            toastMessage: "Error sending message",
            isSucess: false,
            message: 'End the Call and Try Again');
      }
    } else {
      ToastMessage.toastMessage(
          toastMessage: "Connection Error",
          isSucess: false,
          message: 'Check your internet');
    }
  }

  void closeConnection() {
    if (channel != null) {
      channel!.sink.close();
    }
  }

  bool isLoading = false;

  void isLoaded(bool value) {
    isLoading = false;
    isLoading = value;
    notifyListeners();
  }

  String? parseUsername(String message) {
    try {
      final parsed = jsonDecode(message);
      return parsed['username'];
    } catch (e) {
      return null;
    }
  }

  String? parseMessage(String message) {
    try {
      final parsed = jsonDecode(message);
      return parsed['content'];
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }
}
