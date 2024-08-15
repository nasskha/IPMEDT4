import 'package:flutter/material.dart';
import 'package:ipmedt4_project/account_made.dart';
import 'api_service.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isUsernameAvailable = true;
  bool _isCheckingUsername = false;

  final ApiService _apiService = ApiService('http://10.0.2.2:8000');

  void _navigateToLogIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }

  Future<void> _checkUsernameAvailability() async {
    setState(() {
      _isCheckingUsername = true;
    });
    try {
      final response = await _apiService.checkUsername(_usernameController.text);
      setState(() {
        _isUsernameAvailable = response['available'];
      });
    } catch (error) {
      setState(() {
        _isUsernameAvailable = false;
      });
    } finally {
      setState(() {
        _isCheckingUsername = false;
      });
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      if (!_isUsernameAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username is already taken')),
        );
        return;
      }
      try {
        final response = await _apiService.signup(
          _firstNameController.text,
          _lastNameController.text,
          _usernameController.text,
          _passwordController.text,
          _emailController.text,
          _phoneNumberController.text,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountMade()),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 45, right: 30.0),
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
                  padding: EdgeInsets.only(left: 60.0),
                  child: Text(
                    'Mental health matters',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5C5470),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 50),
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
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
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
                          child: const Text(
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
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                        controller: _firstNameController,
                        label: 'First name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _lastNameController,
                        label: 'Last name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _usernameController,
                        label: 'Username',
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _checkUsernameAvailability();
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username.';
                          }
                          if (!_isUsernameAvailable && !_isCheckingUsername) {
                            return 'Username is already taken.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password.';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address.';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _phoneNumberController,
                        label: 'Phone number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number.';
                          } else if (value.length < 8) {
                            return 'Phone number must be at least 8 digits long.';
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Phone number must contain only digits.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFF700B97),
                          ),
                          minimumSize: WidgetStateProperty.all<Size>(
                            const Size(200, 50),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF700B97),
            width: 2.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF700B97),
            width: 2.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF700B97),
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SignUp(),
  ));
}
