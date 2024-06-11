import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: const Center(
        child: Text(
          'This is the Messages page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}