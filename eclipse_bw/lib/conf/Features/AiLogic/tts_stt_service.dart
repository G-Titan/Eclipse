import 'dart:math';

class TTSSTTService {
  // Generate a more context-aware response.
  String generateResponse(String userInput) {
    // Define a map of predefined responses based on specific keywords or topics.
    Map<String, List<String>> topicResponses = {
      'greeting': ['Hello!', 'Hi there!', 'Nice to meet you!'],
      'question': [
        'That\'s an interesting question!',
        'Let me think about that...',
        'I\'m not sure, but I think I can reply you??? does that count as an ability?'
      ],
      'thanks': ['You\'re welcome!', 'No problem, happy to help!', 'Anytime!'],
      'intro': [
        'I am Lavender, I am still in construction but feel free to chat with me while my maker wipes my ass for now '
      ]
      // Add more topics and corresponding responses as needed.
    };

    // Check the user's input for keywords or topics.
    String responseTopic;
    if (userInput.contains('hello') || userInput.contains('hi')) {
      responseTopic = 'greeting';
    } else if (userInput.contains('?')) {
      responseTopic = 'question';
    } else if (userInput.contains('thank')) {
      responseTopic = 'thanks';
    } else if (userInput.contains('this website') ||
        userInput.contains('this app')) {
      responseTopic = 'intro';
    } else if (userInput.contains('yourself')) {
      responseTopic = 'intro';
    } else {
      // If no specific topic is found, use a generic response.
      responseTopic = 'default';
    }

    // Get a random response from the chosen topic or use a generic one.
    List<String> responses = topicResponses[responseTopic] ?? ['Hmm...'];
    int index = Random().nextInt(responses.length);
    return responses[index];
  }

  // Read aloud the received response.
  void readResponseAloud(String response) {
    // Implement the text-to-speech functionality here.
    print('Reading aloud: $response');
  }
}
