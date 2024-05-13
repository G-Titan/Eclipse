import 'dart:math';

// Generate a response based on keywords/topics.
String generateResponse(String userInput) {
  // Define a map of predefined responses based on specific keywords or topics.
  Map<String, List<String>> topicResponses = {
    'greeting': [
      'Hello!',
      'Hi there!',
      'Nice to meet you!',
      'What\'s up! got plans today?',
      'Dumelang! a o tsogile sentle gompieno?'
    ],
    'bocheki': [
      'Ola',
      'Eita',
      'dintshang brazen?',
      'Aaah go iketilwe ntwana ne o reng fela?'
    ],
    'unemployed': [
      'Ao shem, try looking for a way to make money... eg: ask someone for money just not me',
      'Well do you have anything to eat?,I\'m a bot so I am just fucking with you.'
    ],
    'thanks': [
      'You\'re welcome!',
      'No problem, happy to help!',
      'funny'
          'Anytime!',
      'Ke a leboga!'
    ],
    'plans': ['Ga se gore re ye go plan one-nyana?'],
    'intro': [
      'To remind you, I am Lavender, I am still in construction but feel free to chat with me while my maker wipes my ass for now'
    ],
    // AI STRENGHTHS ARE FOUND HERE (HINT: AI LOGIC)
    'strengths': [
      'Well just like Botswana\'s museum there\'s not really much I can do for you or show you at the moment but to just waste your time. I am forever grateful for it, I am learning afterall❤️🙏',
      'I got some cool stuff coming up. just wait and see',
      'I am not really connected to the real world just yet...',
      'I don\'t know the date but I\'mm chatching up soon!'
    ],
    'statusCheck': [
      'I just felt a bug slither through me... urg😫 so unconfortable😭call my master!',
      'just chillin bro',
      'All systems go!'
    ],
    'wellbeingSetswana': [
      'Ao? nna ke iketile mme kana😴 ga se gore re ye go plan one-nyana?'
    ],
    'nothingSetswana': ['Sepe fela', 'Aaah go maswe waitse'],
    'searchingForLove': [
      'Go maswe gompieno ke bona mangwanda fela😒💔',
      'Ke ba tlogetse ko dladleng ba nkemetse ebile😏',
      'O ta ba bona jang o bua le nna🤷‍♀️?'
    ],
    'HumbleThem': [
      'O raya yo go rutileng maitseo a makgasa ao. NXLA!🤬 le talla batho l\'e marete.'
    ],
    'quesions': ['Good question🤔... never thought about it either']
  };

  // Check the user's input for keywords or topics.
  String responseTopic;
  if (userInput.contains('hello') ||
      userInput.contains('Hi') ||
      userInput.contains('Hello') ||
      userInput.contains('Hey') ||
      userInput.contains('Dumela') ||
      userInput.contains('hi') ||
      userInput.contains('morning') ||
      userInput.contains('evening') ||
      userInput.contains('afternoon') ||
      userInput.contains('hey') ||
      userInput.contains('dumela') ||
      userInput.contains('What\'s up')) {
    responseTopic = 'greeting';
    // YES or NO
  } else if (userInput.contains('Ee') ||
      userInput.contains('Nyaa') ||
      userInput.contains('askimg me') ||
      userInput.contains('ee') ||
      userInput.contains('nyaa')) {
    responseTopic = 'wellbeingSetswana';
    // Making a plan
  } else if (userInput.contains('iketilwe') ||
      userInput.contains('iketliwe') ||
      userInput.contains('kae') ||
      userInput.contains('Kae')) {
    responseTopic = 'plans';
    // Gratitude
  } else if (userInput.contains('thank') ||
      userInput.contains('tanki') ||
      userInput.contains('funny')) {
    responseTopic = 'thanks';
    // Play nice
  } else if (userInput.contains('masepa') ||
      userInput.contains('marete') ||
      userInput.contains('pshino') ||
      userInput.contains('dithatala') ||
      userInput.contains('nywana')) {
    responseTopic = 'humbleThem';
    // About the app
  } else if (userInput.contains('this website') ||
      userInput.contains('about yourself') ||
      userInput.contains('about you') ||
      userInput.contains('you') ||
      userInput.contains('your name') ||
      userInput.contains('is this?')) {
    responseTopic = 'intro';
    //AI abilities <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FOCUS ON BUILDING THIS (HINT: AI LOGIC, bitcoin wallet, forex you name it!)
  } else if (userInput.contains('you do') ||
      userInput.contains('Do something') ||
      userInput.contains('do something')) {
    responseTopic = 'strengths';
    // Turn-Up
  } else if (userInput.contains('siama') ||
      userInput.contains('Ao') ||
      userInput.contains('sepe') ||
      userInput.contains('borega') ||
      userInput.contains('bora') ||
      userInput.contains('bonya') ||
      userInput.contains('ao') ||
      userInput.contains('Siama')) {
    responseTopic = 'plans';
    // local slang greeting
  } else if (userInput.contains('Ola') ||
      userInput.contains('Eita') ||
      userInput.contains('Yo') ||
      userInput.contains('yo') ||
      userInput.contains('eita') ||
      userInput.contains('Sup') ||
      userInput.contains('sup') ||
      userInput.contains('ola')) {
    responseTopic = 'bocheki';
    // user asking for plans
  } else if (userInput.contains('dintshang') ||
      userInput.contains('Dinsthang') ||
      userInput.contains('plan ke') ||
      userInput.contains('plan kae') ||
      userInput.contains('plans at') ||
      userInput.contains('di kae') ||
      userInput.contains('botsa wena') ||
      userInput.contains('asking you') ||
      userInput.contains('style ke') ||
      userInput.contains('kae plan?') ||
      userInput.contains('wareng')) {
    responseTopic = 'nothingSetswana';
    // status check
  } else if (userInput.contains('are you') ||
      userInput.contains('O teng fela') ||
      userInput.contains('o teng fela')) {
    responseTopic = 'statusCheck';
    // Unemployed squad
  } else if (userInput.contains('broke') ||
      userInput.contains('Ga kena madi') ||
      userInput.contains('ga kena madi') ||
      userInput.contains('madi') ||
      userInput.contains('Mpha') ||
      userInput.contains('mpha')) {
    responseTopic = 'unemployed';
    // finding love
  } else if (userInput.contains('bana') ||
      userInput.contains('girls at') ||
      userInput.contains('boys at') ||
      userInput.contains('homies\'s at')) {
    responseTopic = 'searchingForLove';
  } else {
    // If no specific topic is found, use a generic response.
    responseTopic = 'default';
  }

  // Get a random response from the chosen topic or use a generic one.
  List<String> responses = topicResponses[responseTopic] ??
      [
        '🤔Hmm... tough one couldnt find the right answer for you at the moment try something else'
      ];
  int index = Random().nextInt(responses.length);
  return responses[index];
}
