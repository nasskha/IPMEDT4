import 'package:flutter/material.dart';
import 'search_friends.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              );
            },
          ),
        ],
      ),
      body: ConversationList(),
    );
  }
}
