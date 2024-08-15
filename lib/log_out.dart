import 'package:flutter/material.dart';
import 'log_in.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                left: 33,
                right: 10,
              ),
              child: Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF5C5470),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action when the Cancel button is pressed
                    print("Cancel button pressed!");
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    side: WidgetStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color(0xFF700B97),
                        width: 2.0,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(120, 50),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color(0xFF5C5470),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Action when the 'Let's get started' button is pressed
                    print("Log out button pressed!");
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LogIn()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFF700B97),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(120, 50),
                    ),
                  ),
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

