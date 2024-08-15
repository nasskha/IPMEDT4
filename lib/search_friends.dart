import 'dart:math';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 183, 164, 1), // Define cameo color using RGB values
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Messenger',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implement friend search functionality here
            },
          ),
        ],
      ),
      body: const ConversationList(),
    );
  }
}

class ConversationList extends StatelessWidget {
  // List of friend names
  final List<String> friendnames = const [
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

  // List of last messages
  final List<String> lastMessages = const [
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

  // List of profile emojis
  final List<String> profileEmojis = const [
    '😄',
    '😊',
    '😔',
    '😢',
    '😡',
    '😴',
    '🥳',
    '😎',
  ];

  const ConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendnames.length,
      itemBuilder: (context, index) {
        // Generate a random index for profile emojis
        int randomIndex = Random().nextInt(profileEmojis.length);

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          margin: const EdgeInsets.all(8.0), // Add margins for visual separation
          child: ListTile(
            leading: CircleAvatar(
              child: Text(profileEmojis[randomIndex], style: const TextStyle(fontSize: 20)),
            ),
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

  const ChatScreen({super.key, required this.friendIndex});

  @override
  Widget build(BuildContext context) {
    // Get friend's name and profile emoji
    String friendName = const ConversationList().friendnames[friendIndex];
    String profileEmoji = const ConversationList().profileEmojis[friendIndex % const ConversationList().profileEmojis.length];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8), // Add some left padding for space
            CircleAvatar(
              child: Text(profileEmoji, style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 8), // Add space between avatar and name
            Expanded(
              child: Text(
                friendName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: ChatMessages(friendName: friendName),
    );
  }
}

class ChatMessages extends StatelessWidget {
  final String friendName;

  const ChatMessages({super.key, required this.friendName});

  // Generate random messages for the chat
  List<String> generateRandomMessages() {
    List<String> messages = [];
    int messageCount = Random().nextInt(10) + 5; // Generate between 5 to 14 messages

    for (int i = 0; i < messageCount; i++) {
      messages.add('Message $i from $friendName');
    }

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    List<String> messages = generateRandomMessages();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageBubble(isSentByMe: index % 2 == 0, text: messages[index]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
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

  const MessageBubble({super.key, required this.isSentByMe, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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

void main() {
  runApp(const MaterialApp(
    home: MessengerScreen(),
  ));
}
