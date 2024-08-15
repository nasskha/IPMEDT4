import 'package:flutter/material.dart';
import 'voortgang.dart';
import 'notitie.dart';
import 'messages.dart';
import 'coaching.dart';
import 'account.dart';
import 'welcome.dart';
import 'api_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICare',
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
        textTheme: const TextTheme(
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
      home: const WelcomePage(),
      // home: const MyHomePage(title: 'ICare', initialPage: 0), // Ensure initialPage is set
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.initialPage = 0});

  final String title;
  final int initialPage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _showWelcomePage = false;

  final ApiService apiService = ApiService('http://127.0.0.1:8000');

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialPage;
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const Color azalea = Color(0xFFF7CBCA);
  static const Color tacao = Color(0xFFF4A88A);
  static const Color albescentWhite = Color(0xFFDDB8AF);
  static const Color cameo = Color(0xFFE9BDBE);
  static const Color coralTree = Color(0xFFA26769);

  String selectedEmoji = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _hideWelcomePage() {
    setState(() {
      _showWelcomePage = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showWelcomePage
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AccountPage(selectedEmoji: selectedEmoji)),
                );
              },
              child: selectedEmoji.isNotEmpty
                  ? Text(
                selectedEmoji,
                style: const TextStyle(fontSize: 30),
              )
                  : const Icon(
                Icons.account_circle,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: _showWelcomePage
          ? WelcomePage(
        onContinue: _hideWelcomePage,
      )
          : IndexedStack(
        index: _selectedIndex,
        children: [
          VoortgangPage(
            updateSelectedEmoji: (emoji) {
              setState(() {
                selectedEmoji = emoji;
              });
            },
          ),
          const NotitiePage(),
          const MessagesPage(),
          const CoachingPage(),
          AccountPage(selectedEmoji: selectedEmoji),
        ],
      ),
      bottomNavigationBar: _showWelcomePage
          ? null
          : ClipPath(
        clipper: BottomNavBarClipper(),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: albescentWhite,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Notes',
              backgroundColor: tacao,
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


