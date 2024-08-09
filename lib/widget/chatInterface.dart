import 'package:flutter/material.dart';
import 'package:gorandom/core/toastMessage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:gorandom/provider/messageProvider.dart';
import 'package:gorandom/widget/chatBubble.dart';

class ChatInterface extends StatefulWidget {
  final String rooomId;
  final String username;
  final String roomName;
  const ChatInterface(
      {super.key,
      required this.rooomId,
      required this.username,
      required this.roomName});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  final TextEditingController messageEditingController =
      TextEditingController();
  final FocusNode messageFocusNode = FocusNode(); // Added focus node

  @override
  void dispose() {
    messageEditingController.dispose();
    messageFocusNode.dispose(); // Dispose the focus node
    super.dispose();
  }

  void _sendMessage(String text) {
    final messageProvider =
        Provider.of<Messageprovider>(context, listen: false);
    if (text.trim().isNotEmpty) {
      messageProvider.sendMessage(text.trim(), widget.username);
      messageEditingController.clear();
      // Manually request focus after sending the message
      FocusScope.of(context).requestFocus(messageFocusNode);
    }
  }

  void _copyRoomId() {
    Clipboard.setData(ClipboardData(text: widget.rooomId)).then((_) {
      ToastMessage.toastMessage(
          toastMessage: "RoomId copied to clipboard",
          message: "Share this id to join your friends",
          isSucess: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                tooltip: "Leave Room",
                onPressed: () {
                  final messageProvider =
                      Provider.of<Messageprovider>(context, listen: false);
                  messageProvider.closeConnection();
                  ToastMessage.toastMessage(
                      toastMessage: "Left Room Chat",
                      isSucess: true,
                      message: 'See You Again');
                  messageProvider.clearMessage();

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomName.toUpperCase(),
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.copy),
                onPressed: _copyRoomId,
                tooltip: 'Copy Room ID',
              ),
            ],
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Consumer<Messageprovider>(
                    builder: (context, provider, child) {
                  return provider.messages.length >= 1
                      ? ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.all(8),
                          itemCount: provider.messages.length,
                          itemBuilder: (context, index) {
                            final message = provider.messages[index];
                            return ChatBubble(
                              message: message['text'],
                              isMe: message['isMe'],
                              username: message['username'],
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "Share RoomID and Enjoy!!",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        focusNode: messageFocusNode, // Assign the focus node
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.black,
                        ),
                        onSubmitted: (value) {
                          _sendMessage(value);
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      tooltip: "Send Message",
                      icon: Icon(
                        Icons.send,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        final text = messageEditingController.text.trim();
                        _sendMessage(text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
