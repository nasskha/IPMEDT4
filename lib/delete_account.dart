import 'package:flutter/material.dart';
import 'log_in.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
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
            SizedBox(height: 20),
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
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        color: Color(0xFF700B97),
                        width: 2.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(120, 50),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color(0xFF5C5470),
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Action when the 'Let's get started' button is pressed
                    print("Delete button pressed!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(120, 50),
                    ),
                  ),
                  child: Text(
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
