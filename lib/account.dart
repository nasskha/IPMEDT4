import 'package:flutter/material.dart';
import 'coaching.dart'; // Assume you have these pages
import 'log_out.dart';



class AccountPage extends StatelessWidget {
  final String selectedEmoji;

  const AccountPage({super.key, required this.selectedEmoji});


  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Profile photo with padding
              SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: selectedEmoji.isNotEmpty
                      ? Text(
                    selectedEmoji,
                    style: const TextStyle(fontSize: 100),
                  )
                      : const Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                    size: 80,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/bronze_badge.png', width: 70, height: 70),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                ],
              ),
              const SizedBox(height: 40),
              const Divider(),
              ListTile(
                title: const Text('Coaching'),
                onTap: () {
                  _navigateToPage(context, const CoachingPage()); // Replace with actual page
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Log Out'),
                onTap: () {
                  _navigateToPage(context, const LogOut()); // Replace with actual page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}