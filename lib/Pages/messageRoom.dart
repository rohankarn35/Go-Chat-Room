import 'package:flutter/material.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:gorandom/widget/chatInterface.dart';
import 'package:provider/provider.dart';

class MessageRoom extends StatelessWidget {
  final String roomId;
  final String userName;
  final String roomName;
  const MessageRoom(
      {super.key,
      required this.roomId,
      required this.userName,
      required this.roomName});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: screenSize.width / 8, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      tooltip: "Close the Room",
                      color: Colors.white,
                      onPressed: () {
                        final messageProvider = Provider.of<Messageprovider>(
                            context,
                            listen: false);
                        messageProvider.closeConnection();
                        ToastMessage.toastMessage(
                            toastMessage: "Ended the Room Chat",
                            isSucess: true,
                            message: 'Come Back Again');
                        // messageProvider.clearMessage();

                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.call_end,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: screenSize.height / 1.2,
                width: screenSize.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ChatInterface(
                    rooomId: roomId,
                    username: userName,
                    roomName: roomName,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
