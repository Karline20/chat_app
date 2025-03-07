import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                if (FirebaseAuth.instance.currentUser == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AuthScreen(),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessages(),
        ],
      ),
    );
  }
}
