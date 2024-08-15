import 'package:flutter/material.dart';
import 'log_in.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback? onContinue;

  const WelcomePage({super.key, this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                top: 200,
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
                bottom: 200,
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
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ElevatedButton(
                onPressed: () {
                  print("Let's get started button pressed!");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                  if (onContinue != null) {
                    onContinue!();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFF700B97),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(
                    const Size(200, 50),
                  ),
                ),
                child: const Text(
                  "Let's get started",
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
    );
  }
}
