import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;

  const MessageBubble({Key? key, required this.sender, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment:
            sender == 'me' ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: sender == 'me' ? Colors.blue : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$sender: $text',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
