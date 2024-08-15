import 'package:flutter/material.dart';
import 'search_friends.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
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