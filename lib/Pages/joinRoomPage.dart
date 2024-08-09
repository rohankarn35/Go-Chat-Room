import 'package:flutter/material.dart';
import 'package:gorandom/Pages/messageRoom.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:gorandom/utils/joinRoom.dart';
import 'package:gorandom/widget/customButton.dart';
import 'package:gorandom/widget/customTextFiled.dart';
import 'package:jumping_dot/jumping_dot.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<Messageprovider>();
      provider.isLoaded(false);
    });
  }

  final FocusNode _focusNode = FocusNode();

  void _keyboardUnfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    joinController.dispose();
    usernameController.dispose();
    _focusNode.unfocus();
    // TODO: implement dispose
    super.dispose();
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
                child: Consumer<Messageprovider>(
                  builder: (context, value, child) {
                    final provider = context.read<Messageprovider>();

                    return Column(
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
                        Custombutton().customButoon(
                          buttonText: "Join",
                          height: 60,
                          width: 200,
                          color: Colors.blue,
                          textColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          fontSize: 20,
                          onpressed: () async {
                            _keyboardUnfocus();
                            if (_formKey.currentState?.validate() ?? false) {
                              provider.isLoaded(true);

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

                                  _navigatetoMessage(roomId,
                                      usernameController.text, roomName);
                                }
                              } else {
                                ToastMessage.toastMessage(
                                    toastMessage: msg,
                                    isSucess: false,
                                    message: 'Restart the App and Try Again');
                              }
                            }
                            usernameController.clear();
                            joinController.clear();
                            provider.isLoaded(false);
                          },
                        ),
                        SizedBox(height: 20),
                        !value.isLoading
                            ? Text(
                                "Press the button above to join a new room.",
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
                  },
                )),
          ),
        ),
      ),
    );
  }
}
