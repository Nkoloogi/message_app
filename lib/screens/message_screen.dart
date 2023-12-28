import 'package:flutter/material.dart';
import 'package:message_screen/screens/callingscreen.dart';
import 'package:message_screen/widgets/messageclass.dart';
import 'package:message_screen/widgets/messagelist.dart';
import 'package:message_screen/widgets/sendmessageinput.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(messages: messages),
          ),
          SendMessageInput(
            onSendMessage: (message, documentPath) {
              setState(() {
                messages.add(Message(
                  sender: 'me',
                  text: message,
                  documentPath: documentPath,
                ));
              });
            },
            onInitiateCall: () {
              // Start the call when the initiate call action is triggered
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CallingScreen(channelName: 'example_channel'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
