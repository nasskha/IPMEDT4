import 'package:flutter/material.dart';
import 'log_in.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

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
                'Are you sure you want to delete account?',
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
                    print("Delete button pressed!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.red,
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(120, 50),
                    ),
                  ),
                  child: const Text(
                    "Delete account",
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

void main() {
  runApp(const MaterialApp(
    home: DeleteAccount(),
  ));
}