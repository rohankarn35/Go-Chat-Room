import 'package:flutter/material.dart';
import 'package:gorandom/Pages/messageRoom.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:gorandom/utils/joinRoom.dart';
import 'package:gorandom/widget/customButton.dart';
import 'package:gorandom/widget/customTextFiled.dart';
import 'package:provider/provider.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final TextEditingController joinController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _navigatetoMessage(String roomId, String userName, String roomName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageRoom(
          roomId: roomId,
          userName: userName,
          roomName: roomName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.link_rounded,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter Room Link or Code",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Customtextfiled().customTextField(
                    hintText: "Enter Username",
                    textEditingController: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Customtextfiled().customTextField(
                    hintText: "Enter Room Code or Link",
                    textEditingController: joinController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a room code or link';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Consumer<Messageprovider>(
                    builder: (context, value, child) {
                      final provider = context.read<Messageprovider>();

                      return Custombutton().customButoon(
                        buttonText: "Join",
                        height: 60,
                        width: 200,
                        color: Colors.blue,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        fontSize: 20,
                        onpressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final String id = joinController.text.trim();
                            Map<String, dynamic> response =
                                await Joinroom().joinRoom(id);
                            bool isCorrect = response["status"];
                            String msg = response["message"];
                            String roomId = response["roomId"];
                            String roomName = response["roomName"];
                            if (isCorrect) {
                              provider.webSocketConnection(roomId);
                              if (value.channel == null) {
                                ToastMessage.toastMessage(
                                    toastMessage: "There might be some issue",
                                    isSucess: false,
                                    message: 'Restart the App and Try Again');
                              } else {
                                ToastMessage.toastMessage(
                                    toastMessage: msg,
                                    isSucess: true,
                                    message: 'Enjoy!!');

                                _navigatetoMessage(
                                    roomId, usernameController.text, roomName);
                              }
                            } else {
                              ToastMessage.toastMessage(
                                  toastMessage: msg,
                                  isSucess: false,
                                  message: 'Restart the App and Try Again');
                            }
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Press the button above to join a new room.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
