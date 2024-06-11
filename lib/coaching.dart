import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CoachingPage extends StatelessWidget {
  const CoachingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coaching'),
      ),
      body: const Center(
        child: Text(
          'This is the Coaching page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}