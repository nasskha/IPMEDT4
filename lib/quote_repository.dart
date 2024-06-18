import 'dart:math';
import 'quotes.dart';

class QuoteRepository {
  static final QuoteRepository _instance = QuoteRepository._internal();

  factory QuoteRepository() {
    return _instance;
  }

  QuoteRepository._internal();

  String getRandomQuote() {
    Random random = Random();
    int index = random.nextInt(quotes.length);
    return quotes[index];
  }
}
