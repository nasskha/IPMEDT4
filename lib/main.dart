import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'voortgang.dart';
import 'notitie.dart';
import 'home.dart';
import 'messages.dart';
import 'coaching.dart';
import 'colors.dart';
import 'account.dart';// Import the account page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-care',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.deepPurple,
        ),
        fontFamily: 'Archivo',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Archivo'),
          bodyMedium: TextStyle(fontFamily: 'Archivo'),
          titleLarge: TextStyle(fontFamily: 'Archivo'),
          titleMedium: TextStyle(fontFamily: 'Archivo'),
          titleSmall: TextStyle(fontFamily: 'Archivo'),
          headlineMedium: TextStyle(fontFamily: 'Archivo'),
          headlineSmall: TextStyle(fontFamily: 'Archivo'),
          displaySmall: TextStyle(fontFamily: 'Archivo'),
          displayMedium: TextStyle(fontFamily: 'Archivo'),
          displayLarge: TextStyle(fontFamily: 'Archivo'),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'I-care'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const Color azalea = Color(0xFFF7CBCA);
  static const Color tacao = Color(0xFFF4A88A);
  static const Color albescentWhite = Color(0xFFDDB8AF);
  static const Color cameo = Color(0xFFE9BDBE);
  static const Color coralTree = Color(0xFFA26769);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> saveEmojiToBackend(String emoji) async {
    final response = await http.post(
      Uri.parse('http://your-backend-url.com/api/voortgang'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer YOUR_API_TOKEN', // Add your authentication token here
      },
      body: jsonEncode(<String, dynamic>{
        'datum': DateTime.now().toIso8601String(),
        'emoji': emoji,
        'progress': 0, // Set progress value appropriately
      }),
    );

    if (response.statusCode == 201) {
      print('Emoji saved successfully');
    } else {
      print('Failed to save emoji: ${response.body}');
    }
  }

  String selectedEmoji = ''; // Store selected emoji here

  void updateSelectedEmoji(String emoji) {
    setState(() {
      selectedEmoji = emoji; // Update selected emoji
    });

    saveEmojiToBackend(emoji); // Save emoji to backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            GestureDetector( // Add GestureDetector for navigation
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()), // Navigate to AccountPage
                );
              },
              child: Text(
                selectedEmoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          NotitiePage(),
          VoortgangPage(updateSelectedEmoji: updateSelectedEmoji),
          MessagesPage(),
          CoachingPage(),
          AccountPage(),

        ],
      ),
      bottomNavigationBar: ClipPath(
        clipper: BottomNavBarClipper(),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: azalea,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Notes',
              backgroundColor: tacao,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Progress',
              backgroundColor: albescentWhite,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
              backgroundColor: cameo,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Coaching',
              backgroundColor: coralTree,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              backgroundColor: darkPinky, // Dark pinky color
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
//ik moet de url van de backend aanpassen!!!!!!!
//anders werkt het niet.
