import 'package:flutter/material.dart';
import 'main.dart';


class AccountMade extends StatefulWidget {
  const AccountMade({super.key});

  @override
  _AccountMadeState createState() => _AccountMadeState();
}

class _AccountMadeState extends State<AccountMade> {
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the next page
    Future.delayed(const Duration(seconds: 4), () {
      // Navigate to the next page after 4 seconds
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'ICare', initialPage: 0)), // Replace with the desired destination page
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can customize the splash screen UI here
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Account has been made', // Text to display
              style: TextStyle(
                fontSize: 28, // Customize the font size
                fontWeight: FontWeight.bold, // Customize the font weight
              ),
            ),
            SizedBox(height:10),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF700B97)),
            ), // Display a loading indicator or any other content
            // Add space between the loading indicator and the text
          ],
        ),
      ),
    );
  }
}

