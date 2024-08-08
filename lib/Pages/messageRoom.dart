import 'package:flutter/material.dart';
import 'package:gorandom/widget/chatInterface.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        const mobileMaxWidth = 600;
        const mobileMaxHeight = 800;
        if (constraints.maxWidth <= mobileMaxWidth ||
            constraints.maxHeight <= mobileMaxHeight) {
          return ChatInterface(
              rooomId: roomId, username: userName, roomName: roomName);
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          );
        }
      },
    );
  }
}
