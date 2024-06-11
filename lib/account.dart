import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: const Center(
        child: Text(
          'This is the Account page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}