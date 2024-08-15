import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> login(String username, String password, bool rememberMe) async {
    final url = Uri.parse('$baseUrl/api/login');
    print('Logging in with username: $username');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'remember_me': rememberMe,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();

      // Store token and user details if 'remember me' is checked
      if (rememberMe) {
        await prefs.setString('username', username);
        await prefs.setString('password', password);
      } else {
        await prefs.remove('username');
        await prefs.remove('password');
      }

      await prefs.setString('token', data['token']);

      return data;
    } else {
      throw Exception('Failed to login');
    }

  }

  Future<Map<String, dynamic>> signup(
      String firstName,
      String lastName,
      String username,
      String password,
      String email,
      String phoneNumber) async {
    final url = Uri.parse('$baseUrl/api/signup');
    print('Attempting to sign up with URL: $url');
    print('Request Body: ${jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'password': password,
      'email': email,
      'phone_number': phoneNumber,
    })}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'password': password,
        'email': email,
        'phone_number': phoneNumber,
      }),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      print('Sign up successful, response data: $responseData');
      return responseData;
    } else {
      final responseBody = json.decode(response.body);
      print('Sign up failed, error: ${responseBody['message']}');
      throw Exception(responseBody['message'] ?? 'Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> checkUsername(String username) async {
    final url = Uri.parse('$baseUrl/api/check_username');
    print('Checking username availability with URL: $url');
    print('Request Body: ${jsonEncode({'username': username})}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check username availability');
    }
  }
}
