import 'dart:math';

class QuotesData {
  static const Map<String, List<String>> moodQuotes = {
    'Happy': [
      "Happiness is not by chance, but by choice.",
      "The most wasted of all days is one without laughter.",
      "Happiness blooms from within.",
      "Smile, it's free therapy.",
      "Joy is the simplest form of gratitude.",
    ],
    'Sad': [
      "Tough times never last, but tough people do.",
      "Every storm runs out of rain.",
      "This feeling is temporary, you are not.",
      "Even the darkest night will end and the sun will rise.",
      "You are stronger than you think.",
    ],
    'Calm': [
      "A calm mind brings inner strength and self-confidence.",
      "Peace begins with a deep breath.",
      "Stillness is where creativity and solutions are found.",
      "Let go of what you can't control.",
      "Breathe. You're going to be okay.",
    ],
    'Angry': [
      "For every minute you remain angry, you give up sixty seconds of peace of mind.",
      "Speak when you are angry and you'll make the best speech you'll ever regret.",
      "Anger is a wind which blows out the lamp of the mind.",
      "Take a deep breath. Let it go.",
      "Anger is temporary, peace is a choice.",
    ],
  };

  static final Random _random = Random();

  /// Returns a random quote for [mood]. Pass [excluding] (the current quote)
  /// so refresh never repeats the same one twice in a row.
  static String getRandomQuote(String mood, {String? excluding}) {
    final quotes = moodQuotes[mood] ?? moodQuotes['Calm']!;
    if (quotes.length == 1) return quotes.first;
    String quote;
    do {
      quote = quotes[_random.nextInt(quotes.length)];
    } while (quote == excluding);
    return quote;
  }
}