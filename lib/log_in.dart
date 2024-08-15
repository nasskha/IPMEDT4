import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'main.dart';
import 'sign_up.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonDisabled = true;
  bool _isRememberMeChecked = false; // State variable for checkbox

  final ApiService _apiService = ApiService('http://10.0.2.2:8000');

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials();
    _usernameController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  Future<void> _loadStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedPassword = prefs.getString('password');
    final rememberMe = storedUsername != null && storedPassword != null;

    if (storedUsername != null) {
      _usernameController.text = storedUsername;
    }
    if (storedPassword != null) {
      _passwordController.text = storedPassword;
    }
    setState(() {
      _isRememberMeChecked = rememberMe;
    });
  }

  void _checkFields() {
    setState(() {
      _isButtonDisabled = _usernameController.text.isEmpty ||
          _passwordController.text.isEmpty;
    });
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }


  Future<void> _handleLogin(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final data = await _apiService.login(username, password, _isRememberMeChecked);
      final token = data['token'];
      // Handle successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'ICare', initialPage: 0)),
      );
    } catch (e) {
      // Handle login failure
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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
              const Padding(
                padding: EdgeInsets.only(
                  top: 45,
                  right: 30.0,
                ),
                child: Text(
                  'iCare',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C5470),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 60.0,
                ),
                child: Text(
                  'Mental health matters',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5C5470),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 60.0,
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
                      const Text(
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
                        child: const Text(
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _usernameController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ), // Border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ), // Border color when enabled
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ), // Border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF700B97),
                            width: 2.0,
                          ), // Border color when enabled
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _isRememberMeChecked,
                          checkColor: Colors.white, // Color of the checkmark
                          activeColor: const Color(0xFF700B97),
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isRememberMeChecked = newValue ?? false;
                            });
                          },
                        ),
                        const Text('Remember me'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                    // Perform login logic here
                    _handleLogin(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      _isButtonDisabled ? Colors.grey : const Color(0xFF700B97),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(200, 50),
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
