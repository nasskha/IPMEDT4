import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'This is the Home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
