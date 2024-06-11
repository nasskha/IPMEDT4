import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Notitie{
  String baseUrl = "http://127.0.0.1:8000/notitie";
}

class NotitiePage extends StatelessWidget {
  const NotitiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: const Center(
        child: Text(
          'This is the Notes page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
