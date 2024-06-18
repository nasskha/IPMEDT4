import 'package:flutter/material.dart';
import 'main.dart'; // Import your main.dart where MyApp is defined
import 'sign_up.dart';

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
      MaterialPageRoute(builder: (context) => SignUp()), // Navigate to sign up page
    );
  }

  void _checkFields() {
    setState(() {
      _isButtonDisabled = _usernameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  void _handleLogin(BuildContext context) {
    // Simulate login logic; replace with actual authentication logic
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == 'admin' && password == 'password') {
      // Navigate to main application screen (MyApp)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    } else {
      // Show error dialog or message for invalid credentials (not implemented here)
      print('Invalid credentials');
    }
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Logo and subtitle
              Padding(
                padding: const EdgeInsets.only(top: 45, right: 30.0),
                child: Text(
                  'iCare',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C5470),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'Mental health matters',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5C5470),
                  ),
                ),
              ),

              // Log In title
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 50),
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

              // Not a member text and sign up link
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
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

              // Username and Password fields
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
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
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // Remember Me checkbox
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text('Remember me'),
                      ],
                    ),
                  ],
                ),
              ),

              // Log in button
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                    // Handle login button press
                    _handleLogin(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isButtonDisabled ? Colors.grey : Color(0xFF700B97),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(200, 50),
                    ),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
