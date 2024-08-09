import 'package:flutter/material.dart';
import 'package:gorandom/Pages/messageRoom.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:gorandom/utils/createRoom.dart';
import 'package:gorandom/widget/customButton.dart';
import 'package:gorandom/widget/customTextFiled.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final TextEditingController roomNameTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _navigatetoMessage(String roomId, String userName, String roomName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageRoom(
                roomId: roomId, userName: userName, roomName: roomName)));
  }

  void _keyboardUnfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    final provider = context.read<Messageprovider>();
    provider.isLoaded(false);
    // TODO: implement initState
    super.initState();
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
                child:
                    Consumer<Messageprovider>(builder: (context, value, child) {
                  final provider = context.read<Messageprovider>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 100,
                        color: Colors.redAccent,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Create a New Room",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Customtextfiled().customTextField(
                        textEditingController: roomNameTextEditingController,
                        hintText: "Enter Room Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a room name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Customtextfiled().customTextField(
                        textEditingController: usernameTextEditingController,
                        hintText: "Enter Username",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      Custombutton().customButoon(
                        buttonText: "Create New Room",
                        height: 60,
                        width: 200,
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        fontSize: 18,
                        onpressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _keyboardUnfocus();
                            provider.isLoaded(true);

                            String roomId = await Createroom().createRoom(
                              roomName: roomNameTextEditingController.text,
                              username: usernameTextEditingController.text,
                            );

                            if (roomId.isNotEmpty) {
                              provider.webSocketConnection(roomId);
                              if (value.channel == null) {
                                ToastMessage.toastMessage(
                                    toastMessage: "Something Went Wrong",
                                    isSucess: false,
                                    message: 'Go Back and Try again');
                              } else {
                                ToastMessage.toastMessage(
                                    toastMessage: "Connection Successful",
                                    isSucess: true,
                                    message: 'Ready to Chat');

                                _navigatetoMessage(
                                    roomId,
                                    usernameTextEditingController.text,
                                    roomNameTextEditingController.text);
                              }
                            } else {
                              ToastMessage.toastMessage(
                                  toastMessage: "Something went wrong",
                                  isSucess: false,
                                  message: 'Go Back and Try again');
                            }
                            usernameTextEditingController.clear();
                            roomNameTextEditingController.clear();
                            provider.isLoaded(false);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      !value.isLoading
                          ? Text(
                              "Press the button above to start a new room.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : JumpingDots(
                              color: Colors.white,
                            )
                    ],
                  );
                })),
          ),
        ),
      ),
    );
  }
}
