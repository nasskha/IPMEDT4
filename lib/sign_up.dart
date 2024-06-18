import 'package:flutter/material.dart';
import 'package:ipmedt4_project/account_made.dart';
import 'log_in.dart';
import 'account_made.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  void _navigateToLogIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogIn()), // Change SignUpPage to your sign-up page widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centreert de inhoud verticaal
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 45,
                          right: 30.0), // Voeg extra ruimte toe aan de rechterkant van de tekst
                      child: Text(
                        'iCare',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C5470), // Vervang door de gewenste kleur
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0), // Adjust the left padding as needed
                      child: Text(
                        'Mental health matters',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5C5470),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0, // Adjust the space between the subtitle and login title
                        left: 50,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Become a Member!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C5470),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Already a member? ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _navigateToLogIn(context);
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF5C5470),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Username&Password
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0, // Adjust the space between the login title and input fields
                        left: 30.0,
                        right: 30.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'First name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23), // Add space between username and password fields
                          TextField(
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23), // Add space between username and password fields
                          TextField(
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23),
                          TextField(
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Email adress',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23), // Add space between username and password fields
                          TextField(
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 23),
                        ],
                      ),
                    ),


                    //Button
                    const SizedBox(height: 1), // Ruimte tussen de subtitel en de knop
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 35,
                          bottom: 50,
                      ),
                      child: ElevatedButton(

                        onPressed: () {

                          // Actie wanneer de knop wordt ingedrukt
                          print("Sign up button pressed!");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AccountMade()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF700B97), // Change button color here
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(200, 50), // Set the minimum width and height of the button
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white, // Change text color here
                            fontSize: 16,
                          ), // Tekst op de knop
                        ),
                      ),
                    ),



                  ]
              )
          )
        )

    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUp(),
  ));
}