import 'package:flutter/material.dart';
import 'log_in.dart';

class WelcomePage extends StatelessWidget {


  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBD8E3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centreert de inhoud verticaal
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 200,
                  right: 30.0), // Voeg extra ruimte toe aan de rechterkant van de tekst
              child: Text(
                'iCare',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C5470), // Vervang door de gewenste kleur
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 200,
                  left: 60.0), // Adjust the left padding as needed
              child: Text(
                'Mental health matters',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5C5470),
                ),
              ),
            ),

            const SizedBox(height: 1), // Ruimte tussen de subtitel en de knop
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ElevatedButton(

                onPressed: () {

                  // Actie wanneer de knop wordt ingedrukt
                  print("Let's get started button pressed!");
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF700B97), // Change button color here
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(200, 50), // Set the minimum width and height of the button
                  ),
                ),
                child: const Text(
                    "Let's get started",
                    style: TextStyle(
                    color: Colors.white, // Change text color here
                    fontSize: 16,
                    ), // Tekst op de knop
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: WelcomePage(),
  ));
}