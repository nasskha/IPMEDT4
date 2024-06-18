import 'package:flutter/material.dart';
import 'package:ipmedt4_project/messages.dart';
import 'search_friends.dart';

class MessengerScreen extends StatelessWidget {
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
