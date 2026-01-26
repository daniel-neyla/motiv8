import 'dart:math';
import 'quotes.dart';

class QuoteService {
  static final _random = Random();

  static String randomQuote() {
    return motivationalQuotes[_random.nextInt(motivationalQuotes.length)];
  }
}
