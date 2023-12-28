import 'package:flutter/material.dart';
import 'package:message_screen/widgets/messagebubble.dart';
import 'package:message_screen/widgets/messageclass.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;

  const MessageList({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return MessageBubble(sender: message.sender, text: message.text);
      },
    );
  }
}
