import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'main.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
  }

class _LogInState extends State<LogIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()), // Change SignUpPage to your sign-up page widget
    );
  }

  void _checkFields() {
    setState(() {
      _isButtonDisabled = _usernameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center( // Add SingleChildScrollView here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centreert de inhoud verticaal
            children: <Widget>[
              //LOGO
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

              //Log In
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0, // Adjust the space between the subtitle and login title
                  left: 50,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Log in',
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
                        'Not a member? ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigateToSignUp(context);
                        },
                        child: Text(
                          'Become a member',
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
                      controller: _usernameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10), // Add space between username and password fields
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    //Remember Me
                    SizedBox(height: 10), // Add space between password field and checkbox
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}), // Remember me checkbox
                        Text('Remember me'),
                      ],
                    ),
                  ],
                ),
              ),

              //Button
              const SizedBox(height: 1), // Ruimte tussen de subtitel en de knop
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _isButtonDisabled ? null : () {
                    // Actie wanneer de knop wordt ingedrukt
                    print("Log in button pressed!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isButtonDisabled ? Colors.grey : Color(0xFF700B97), // Change button color here
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(200, 50), // Set the minimum width and height of the button
                    ),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white, // Change text color here
                      fontSize: 16,
                    ), // Tekst op de knop
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LogIn(),
  ));
}
