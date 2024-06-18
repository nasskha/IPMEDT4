import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For iOS style transition
import 'main.dart';

void main() {
  runApp(MaterialApp(
    home: AccountMade(), // Set the initial route to the SplashScreen
  ));
}

class AccountMade extends StatefulWidget {
  @override
  _AccountMadeState createState() => _AccountMadeState();
}

class _AccountMadeState extends State<AccountMade> {
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the next page
    Future.delayed(Duration(seconds: 4), () {
      // Navigate to the next page after 4 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()), // Replace with the desired destination page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can customize the splash screen UI here
    return Scaffold(
      backgroundColor: Color(0xFFDBD8E3), // Customize the background color
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
            CircularProgressIndicator(), // Display a loading indicator or any other content
            // Add space between the loading indicator and the text

          ],
        ),
      ),
    );
  }
}


