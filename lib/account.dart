import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ipmedt4_project/edit_profile_picture.dart';
import 'manage_account.dart';
import 'coaching.dart'; // Assume you have these pages
import 'log_out.dart';
import 'delete_account.dart';


class AccountPage extends StatelessWidget {
  final String selectedEmoji;

  const AccountPage({Key? key, required this.selectedEmoji}) : super(key: key);


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
              Padding(
                padding: const EdgeInsets.only(
                    right: 20),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: selectedEmoji.isNotEmpty
                      ? Text(
                    selectedEmoji,
                    style: TextStyle(fontSize: 100),
                  )
                      : Icon(
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
                  SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                  SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                  SizedBox(width: 10),
                  Image.asset('assets/images/empty_badge.png', width: 70, height: 70),
                ],
              ),
              SizedBox(height: 40),
              Divider(),
              ListTile(
                title: Text('Coaching'),
                onTap: () {
                  _navigateToPage(context, CoachingPage()); // Replace with actual page
                },
              ),
              Divider(),
              ListTile(
                title: Text('Log Out'),
                onTap: () {
                  _navigateToPage(context, LogOut()); // Replace with actual page
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  _navigateToPage(context, DeleteAccount()); // Replace with actual page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}