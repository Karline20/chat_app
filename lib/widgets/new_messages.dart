import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  NewMessages({super.key});

  @override
  State<StatefulWidget> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessages> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    //send to firebase

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Send a message...',
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              color: Theme.of(context).colorScheme.onSurface,
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
