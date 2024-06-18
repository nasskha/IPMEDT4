import 'package:flutter/material.dart';
import 'log_in.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback? onContinue;

  const WelcomePage({Key? key, this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBD8E3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
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
            Padding(
              padding: const EdgeInsets.only(
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
                  if (onContinue != null) {
                    onContinue!(); // Call the onContinue callback
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF700B97),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(200, 50),
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
