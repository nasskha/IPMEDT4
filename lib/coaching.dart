import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coaching App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CoachingPage(),
    );
  }
}

class CoachingPage extends StatelessWidget {
  const CoachingPage({Key? key}) : super(key: key);

  static const Color widgetColor = Color(0xFFE6E0DA); // New color for widgets
  static const Color buttonColor = Color(0xFFD0AFD5); // Color for buttons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coaching'),
        backgroundColor: widgetColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SubscriptionCard(
              title: 'Basic Package',
              description: 'Een keer per maand online coaching + toegang tot beperkte aantal mental health artikelen.',
              price: '€9.99',
              buttonColor: buttonColor,
              cardColor: widgetColor, // Set the card color to widgetColor
            ),
            SubscriptionCard(
              title: 'Pro Package',
              description: 'Een keer per week online coaching + toegang tot alle mental health artikelen.',
              price: '\€19.99',
              buttonColor: buttonColor,
              cardColor: widgetColor, // Set the card color to widgetColor
            ),
            SubscriptionCard(
              title: 'Premium Package',
              description: 'Dagelijks online coaching + toegan tot alle mental health artikelen + cursussen en trainingen over stressmanagement + kortingen op supplementen.',
              price: '\€39.99',
              buttonColor: buttonColor,
              cardColor: widgetColor, // Set the card color to widgetColor
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final Color buttonColor;
  final Color cardColor; // New color for the card

  const SubscriptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.buttonColor,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor, // Set the card color
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 8.0),
            Text(
              price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // Corrected to buttonColor
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                },
                child: const Text(
                  'Aanschaffen',
                  style: TextStyle(color: Colors.black), // Set text color to black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betalingsmogelijkheden'),
        backgroundColor: CoachingPage.widgetColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PaymentOption(
            name: 'iDEAL',
            logo: 'assets/logos/ideal.png', // Make sure to add the actual asset
          ),
          PaymentOption(
            name: 'Credit Card',
            logo: 'assets/logos/cc.png', // Make sure to add the actual asset
          ),
          PaymentOption(
            name: 'Klarna',
            logo: 'assets/logos/klarna.png', // Make sure to add the actual asset
          ),
          PaymentOption(
            name: 'PayPal',
            logo: 'assets/logos/paypal.png', // Make sure to add the actual asset
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: false, // Hier moet de logica komen om de checkbox status bij te houden
                onChanged: (value) {
                  // Implementeer logica om checkbox status te veranderen
                },
              ),
              Text.rich(
                TextSpan(
                  text: 'Akkoord met ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'betaalvoorwaarden',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class PaymentOption extends StatelessWidget {
  final String name;
  final String logo;

  const PaymentOption({
    Key? key,
    required this.name,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Implementeer hier de betalingsfunctionaliteit
      },
      leading: Image.asset(logo, width: 50),
      title: Text(name),
    );
  }
}


