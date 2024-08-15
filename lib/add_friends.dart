import 'package:flutter/material.dart';
import 'package:ipmedt4_project/messages.dart';
import 'search_friends.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagesPage()),
              );
            },
          ),
        ],
      ),
      body: const ConversationList(),
    );
  }
}