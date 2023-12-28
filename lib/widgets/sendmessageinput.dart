import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SendMessageInput extends StatefulWidget {
  final Function(String, String?) onSendMessage;
  final VoidCallback onInitiateCall; // New callback for initiating calls

  const SendMessageInput(
      {Key? key, required this.onSendMessage, required this.onInitiateCall})
      : super(key: key);

  @override
  _SendMessageInputState createState() => _SendMessageInputState();
}

class _SendMessageInputState extends State<SendMessageInput> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedDocumentPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () async {
                String? filePath = await FilePicker.platform.pickFiles().then(
                  (value) {
                    return value?.files.single.path;
                  },
                );
                setState(() {
                  _selectedDocumentPath = filePath;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.videocam), // Add a button to initiate video call
              onPressed: widget.onInitiateCall,
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                final message = _textController.text;
                widget.onSendMessage(message, _selectedDocumentPath);
                _textController.clear();
                setState(() {
                  _selectedDocumentPath = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
