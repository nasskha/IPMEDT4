import 'package:flutter/material.dart';

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
              // Implement friend search functionality here
            },
          ),
        ],
      ),
      body: ConversationList(),
    );
  }
}

class ConversationList extends StatelessWidget {
  // lijst met namen
  final List<String> friendnames =[
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emily',
    'Frank',
    'Gina',
    'Henry',
    'Ivy',
    'Jack'
  ];
  final List<String> lastMessages = [
    'Hey, how are you?',
    'What\'s up?',
    'Ready for the meeting?',
    'Let\'s grab lunch!',
    'Can you send me the file?',
    'Thanks for the help!',
    'Looking forward to it!',
    'Did you see the game?',
    'Remember to call me!',
    'Let\'s plan our trip!',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendnames.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          margin: EdgeInsets.all(8.0), // Voeg marges toe voor de visuele scheiding
          child: ListTile(
            title: Text(friendnames[index]),
            subtitle: Text(lastMessages[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen(friendIndex: index)),
              );
            },
          ),
        );
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  final int friendIndex;

  ChatScreen({required this.friendIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Friend $friendIndex'),
      ),
      body: ChatMessages(),
    );
  }
}

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 20, // Example message count
            itemBuilder: (context, index) {
              return MessageBubble(isSentByMe: index % 2 == 0, text: 'Message $index');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Implement send message functionality here
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isSentByMe;
  final String text;

  MessageBubble({required this.isSentByMe, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
