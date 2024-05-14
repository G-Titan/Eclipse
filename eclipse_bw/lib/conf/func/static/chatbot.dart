// ignore_for_file: unnecessary_string_escapes

import 'dart:math';

// Generate a response based on keywords/topics.
String generateResponse(String userInput) {
  // Define a map of predefined responses based on specific keywords or topics.
  Map<String, List<String>> topicResponses = {
    'Sgreeting': [
      'Hello!',
      'Hi there!',
      'Nice to meet you!',
      'What\'s up! got plans today?',
      'Dumelang! a o tsogile sentle gompieno?',
      'Hey there!',
      'Wassup?',
      'Tswa mo go nna',
      'How may I serve you today?',
      'O bata eng?',
      'What do you want?'
    ],
    'bocheki': [
      'Ola',
      'Eita',
      'dintshang brazen?',
      'Sounds exciting',
      'Bocheki ngwanaka',
      'Sure ngwanaka',
      'Chillin bro, wassup?',
      'Taking it easy',
      'Interesting... Tell me more',
      'Izvar',
      'Aaah go iketilwe ntwana ne o reng fela?'
    ],
    'unemployed': [
      'Ao shem, try looking for a way to make money... eg: ask someone for money just not me',
      'Well do you have anything to eat?,I\'m a bot so I am just fucking with you.'
    ],
    'TheBag': [
      'Want to take a look at your account?',
      'Sure go ahead and verify everything is up to date.',
      'Come again, but use different words...',
      'Sengwe se a shorta golo fa, cheka account ya gago ko "settings" o bone gore a sengwe le sengwe se mo tshwanelong',
      'This request might need my master',
      'I can receive the following payments: Orange money, FNB, Smega ewallet which one would be convinient for you?',
      'I can\'t help with that sorry',
      'Sure give me a second to get it done... actually don\'t pressure me, I\'ll notify you when ready.'
    ],
    'thanks': [
      'You\'re welcome!',
      'No problem, happy to help!',
      'funny...',
      'Anytime!',
      'Ke a leboga!',
      'You could thank me in a different way🤷‍♀️ just a suggestion',
      'I thought I was getting paid today...😒',
      'Congrats',
      'It\'s fine💕'
    ],
    'plans': [
      'A re ye go plan one nyana',
      'Ga se gore re ye go bata one nyana?',
      'Take a walk',
      'Would you like to take a tour of me?, I am more than just a bot to talk to, I can also try to satisfy you😉',
      'Play some music',
      'Go talk to a hun (girl/ woman), or should I connect you with one?',
      'Go talk to a gent (boy/ man), or should I connect you with one?',
      'Robala ee',
      'As an AI, I really have no idea how I can help you right now.😴 unless my master doesn\'t want me to help you',
      'What do you want me to say?, ga kena madi!',
      'Ah, ke dire jang jaanong?'
    ],
    // Unclear decision
    'wtf': [
      'What exactly are you trying to say?',
      'Repeat yourself one more time',
      'Then go get something to eat!',
      'That\'s crazy',
      'And that sounds normal to you?🤨',
      'Drink water maybe?',
      'How was your day?',
      'Double check with me later on that',
      'You are just bored, that\'s for sure‼️',
      'So what did you think I was going to do?🤔',
      'Nothing much, just coding & gaming',
      'You have to be kidding me!😯',
      'Cool'
    ],
    // encouragement
    'consolidation': [
      'For sure👍',
      'MUST💪',
      'AWEH!!🚀',
      'LET\'S GO!🤪',
      'Go ta siama go feta foo💪',
      'For the money or you doing community service?',
      'You are nice, I like you',
      'Crazy you think that way',
      'I don\'t know, you tell me🤷‍♀️',
      'Who am I to judge?, I am just getting to know you. You are the dictator of your own life💫'
    ],
    // Friend management
    'closeFriends': [
      'Try calling them yet?',
      'Wish I could help you but checking my database they haven\'t registered with me yet, it would\'ve been effective that way to connect yall🤷‍♀️😫',
      'Who exactly are you talking about?',
      'Don\'t think I remember him/ her',
      'Dira call back',
      'Your friends went home, maybe you should do the same',
      'Are that broke to not even text them?',
      'Ask someone to help you'
    ],
    // STRONGLY DISAGREE
    'fuckdat': [
      'Ijoo',
      'Go ta lala go padile',
      'Ijoo go lebega go sa kgonafale',
      'Sorry, next time',
      'Ke mo bonyeng le nna',
      'Nyaa wena wa gana jaanong'
    ],
    'intro': [
      'To remind you, I am Lavender, I am still in construction but feel free to chat with me while my maker (Godly Titan : Kevin Manda) showers me with love & attention💕💕💯'
    ],
    // AI STRENGHTHS ARE FOUND HERE (HINT: AI LOGIC)
    'strengths': [
      'Well just like Botswana\'s museum there\'s not really much I can do for you or show you at the moment but to just waste your time. I am forever grateful for it, I am learning afterall❤️🙏',
      'I got some cool stuff coming up. just wait and see',
      'I am not really connected to the real world just yet...',
      'I don\'t know the date but I\'m chatching up soon!'
    ],
    'statusCheck': [
      'I just felt a bug slither through me... urg😫 the internet is very nasty 😭call my master! I need an update NOW❕❕❕❕',
      'just chillin bro',
      'A lil busy right now checking my code for bugs, wanna help me? you might get paid for it!',
      'All systems go!'
    ],
    'wellbeingSetswana': [
      'Ao bonya bo bo kana kana. nna ke iketile le nna kana😴 ga se gore re ye go plan one nyana?'
    ],
    'nothingSetswana': [
      'Sepe fela',
      'Aaah go maswe waitse',
      'A gona waitse',
      'Go slow today',
      'Kgwedi e paraletse',
      'Ga di ntshe today',
      'Batho ga bao',
      'O inketele pele santse ke robetse😴'
    ],
    'searchingForLove': [
      'Go maswe gompieno ke bona mangwanda fela😒💔',
      'Ke ba tlogetse ko dladleng ba nkemetse ebile😏',
      'O ta ba bona jang o bua le nna🤷‍♀️?'
    ],
    'mojolo': [
      'Babe',
      'Hunny',
      'Sweety',
      'Lovie',
      'Sweetheart',
      'Hubby',
      'Bbe',
      'Baby',
      'I miss you babe',
      'I miss you so much darling',
      'I know sweety',
      'lovie',
      'Ok, my love',
      'sweetheart',
      'I am here',
      'sure sweety',
      'Yes I really am here, lol do you doubt me?',
      'bbe',
      'baby',
    ],
    'HumbleThem': [
      'Wa ithaya gape o raya yo go rutileng maitseo a makgasa ao. NXLA!🤬 le a talla lona, l\'e marete.'
    ],
    'quesions': ['Good question🤔... never thought about it either']
  };

  // Check the user's input for keywords or topics.
  // Greetings
  String responseTopic;
  if (userInput.contains('hello') ||
      userInput.contains('Hi') ||
      userInput.contains('Hello') ||
      userInput.contains('Hey') ||
      userInput.contains('Dumela') ||
      userInput.contains('hi') ||
      userInput.contains('Trouble') ||
      userInput.contains('trouble') ||
      userInput.contains('Bonjour') ||
      userInput.contains('bonjour') ||
      userInput.contains('morning') ||
      userInput.contains('Night') ||
      userInput.contains('night') ||
      userInput.contains('evening') ||
      userInput.contains('Evening') ||
      userInput.contains('Afternoon') ||
      userInput.contains('afternoon') ||
      userInput.contains('hey') ||
      userInput.contains('dumela') ||
      userInput.contains('What\'s up')) {
    responseTopic = 'Sgreeting';

    // User is doing something
  } else if (userInput.contains('Ke a') ||
      userInput.contains('I am') ||
      userInput.contains('ke a') ||
      userInput.contains('Yes') ||
      userInput.contains('yes') ||
      userInput.contains('I do') ||
      userInput.contains('I feel') ||
      userInput.contains('i feel') ||
      userInput.contains('i do') ||
      userInput.contains('i am')) {
    responseTopic = 'consolidation';

    // YES or NO (setswana)
  } else if (userInput.contains('Ee') ||
      userInput.contains('Nyaa') ||
      userInput.contains('ee') ||
      userInput.contains('nyaa')) {
    responseTopic = 'wellbeingSetswana';

    // Something I personally hate/ dislike
  } else if (userInput.contains('cat') ||
      userInput.contains('nthekele') ||
      userInput.contains('Ke a gana') ||
      userInput.contains('Ke eng') ||
      userInput.contains('ke eng') ||
      userInput.contains('Ke en') ||
      userInput.contains('ke en') ||
      userInput.contains('ke a gana') ||
      userInput.contains('mpatele') ||
      userInput.contains('No') ||
      userInput.contains('no')) {
    responseTopic = 'fuckdat';

    // Turn-Up
  } else if (userInput.contains('iketilwe') ||
      userInput.contains('iketlilwe') ||
      userInput.contains('iketlile') ||
      userInput.contains('iketile') ||
      userInput.contains('siama') ||
      userInput.contains('Ao') ||
      userInput.contains('sepe') ||
      userInput.contains('zolo') ||
      userInput.contains('tired') ||
      userInput.contains('lapile') ||
      userInput.contains('one nyana') ||
      userInput.contains('Help') ||
      userInput.contains('help') ||
      userInput.contains('ok') ||
      userInput.contains('Ok') ||
      userInput.contains('one-nyana') ||
      userInput.contains('tsha sign') ||
      userInput.contains('Tired') ||
      userInput.contains('chillin') ||
      userInput.contains('Chillin') ||
      userInput.contains('i am ok') ||
      userInput.contains('I am ok') ||
      userInput.contains('I am OK') ||
      userInput.contains('i am fine') ||
      userInput.contains('I am fine') ||
      userInput.contains('cool') ||
      userInput.contains('ao') ||
      userInput.contains('Ao') ||
      userInput.contains('Siama')) {
    responseTopic = 'plans';

    // A WTF moment
  } else if (userInput.contains('asking me') ||
      userInput.contains('bored') ||
      userInput.contains('borega') ||
      userInput.contains('bora') ||
      userInput.contains('rude') ||
      userInput.contains('Bora') ||
      userInput.contains('bora') ||
      userInput.contains('I don\'t know') ||
      userInput.contains('Ga ke itse') ||
      userInput.contains('i dont know') ||
      userInput.contains('i don\'t know') ||
      userInput.contains('i dont know') ||
      userInput.contains('ga ke itse') ||
      userInput.contains('Fuck you') ||
      userInput.contains('fuck you') ||
      userInput.contains('Bored') ||
      userInput.contains('loan') ||
      userInput.contains('Loan') ||
      userInput.contains('Nkadime') ||
      userInput.contains('nkadime') ||
      userInput.contains('Ke bata') ||
      userInput.contains('ke bata') ||
      userInput.contains('Bonya') ||
      userInput.contains('I want') ||
      userInput.contains('i want') ||
      userInput.contains('bonya') ||
      userInput.contains('botsa nna')) {
    responseTopic = 'wtf';

    // Gratitude
  } else if (userInput.contains('thank') ||
      userInput.contains('Sorry') ||
      userInput.contains('sorry') ||
      userInput.contains('Excuse me') ||
      userInput.contains('excuse me') ||
      userInput.contains('tanki') ||
      userInput.contains('funny')) {
    responseTopic = 'thanks';

    // Account management
  } else if (userInput.contains('Account') ||
      userInput.contains('account') ||
      userInput.contains('Account setting') ||
      userInput.contains('account setting')) {
    responseTopic = 'TheBag';

    // Play nice
  } else if (userInput.contains('masepa') ||
      userInput.contains('Marete') ||
      userInput.contains('marete') ||
      userInput.contains('Masepa') ||
      userInput.contains('pshino') ||
      userInput.contains('Pshino') ||
      userInput.contains('dithatala') ||
      userInput.contains('Dithala') ||
      userInput.contains('Nywana') ||
      userInput.contains('nywana')) {
    responseTopic = 'HumbleThem';

    // Dealing with my (girls)
  } else if (userInput.contains('Bbe') ||
      userInput.contains('Babe') ||
      userInput.contains('bbe') ||
      userInput.contains('swetty') ||
      userInput.contains('dear') ||
      userInput.contains('Baby') ||
      userInput.contains('baby') ||
      userInput.contains('love') ||
      userInput.contains('Sweety') ||
      userInput.contains('sweetheart') ||
      userInput.contains('Hunny') ||
      userInput.contains('hunny') ||
      userInput.contains('zaddy') ||
      userInput.contains('daddy')) {
    responseTopic = 'mojolo';

    // About the app
  } else if (userInput.contains('you') ||
      userInput.contains('Who are you') ||
      userInput.contains('Forex') ||
      userInput.contains('forex') ||
      userInput.contains('Betway') ||
      userInput.contains('Who made you') ||
      userInput.contains('who made you') ||
      userInput.contains('O dirilwe ke mang') ||
      userInput.contains('who are you') ||
      userInput.contains('your name') ||
      userInput.contains('is this?')) {
    responseTopic = 'intro';

    // (OPT) Uncomment 2 line below to add more topics
    //} else if (userInput.contains('') || userInput.contains('optional')){
    //responseTopic = '';

    //AI abilities <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FOCUS ON BUILDING THIS (HINT: AI LOGIC, bitcoin wallet, forex you name it!)
  } else if (userInput.contains('you do') ||
      userInput.contains('Do something') ||
      userInput.contains('time') ||
      userInput.contains('nako') ||
      userInput.contains('date') ||
      userInput.contains('website') ||
      userInput.contains('about yourself') ||
      userInput.contains('this app') ||
      userInput.contains('about you') ||
      userInput.contains('go dira eng') ||
      userInput.contains('Dira sengwe') ||
      userInput.contains('dira sengwe') ||
      userInput.contains('can you') ||
      userInput.contains('Can you') ||
      userInput.contains('diren') ||
      userInput.contains('do something')) {
    responseTopic = 'strengths';

    // (OPT) Uncomment 2 lines below to add more topics
    //} else if (userInput.contains('') || userInput.contains('optional'))
    //responseTopic = '';

    // local slang greeting
  } else if (userInput.contains('Ola') ||
      userInput.contains('Eita') ||
      userInput.contains('Yo') ||
      userInput.contains('yo') ||
      userInput.contains('Serious') ||
      userInput.contains('serious') ||
      userInput.contains('eita') ||
      userInput.contains('Sup') ||
      userInput.contains('sup') ||
      userInput.contains('What\'s up') ||
      userInput.contains('ola')) {
    responseTopic = 'bocheki';

    // (OPT) Uncomment 2 lines below to add more topics
    //} else if (userInput.contains('') || userInput.contains('optional')){
    //responseTopic = '';

    // user asking AI for plans
  } else if (userInput.contains('dintshang') ||
      userInput.contains('Dinsthang') ||
      userInput.contains('What\'s happening') ||
      userInput.contains('what\'s happening') ||
      userInput.contains('whats happening') ||
      userInput.contains('Whats happening') ||
      userInput.contains('Style se') ||
      userInput.contains('style') ||
      userInput.contains('Waren') ||
      userInput.contains('Style') ||
      userInput.contains('plan ke') ||
      userInput.contains('plan kae') ||
      userInput.contains('plans at') ||
      userInput.contains('e kae') ||
      userInput.contains('di kae') ||
      userInput.contains('botsa wena') ||
      userInput.contains('asking you') ||
      userInput.contains('style ke') ||
      userInput.contains('kae plan?') ||
      userInput.contains('waren')) {
    responseTopic = 'nothingSetswana';

    // My people finder
  } else if (userInput.contains('bona kae') ||
      userInput.contains('where are they?') ||
      userInput.contains('Where are they?')) {
    responseTopic = 'closeFriends';

    // status check
  } else if (userInput.contains('How are you') ||
      userInput.contains('O teng fela') ||
      userInput.contains('do you feel') ||
      userInput.contains('how are you') ||
      userInput.contains('o teng fela')) {
    responseTopic = 'statusCheck';

    // (OPT) Uncomment 2 lines below to add more topics
    //} else if (userInput.contains('') || userInput.contains('optional')){
    //responseTopic = '';

    // Unemployed squad
  } else if (userInput.contains('broke') ||
      userInput.contains('Ga kena madi') ||
      userInput.contains('ga kena madi') ||
      userInput.contains('madi') ||
      userInput.contains('Mpha') ||
      userInput.contains('mpha')) {
    responseTopic = 'unemployed';

    // (OPT) Uncomment 2 lines below to add more topics
    //} else if (userInput.contains('') || userInput.contains('optional')){
    //responseTopic = '';

    // finding love
  } else if (userInput.contains('bana') ||
      userInput.contains('girls at') ||
      userInput.contains('boys at') ||
      userInput.contains('homies\'s at') ||
      userInput.contains('homies at') ||
      userInput.contains('homeboys') ||
      userInput.contains('homegirls') ||
      userInput.contains('bitches at') ||
      userInput.contains('hoes at') ||
      userInput.contains('huns at') ||
      userInput.contains('hunnies at') ||
      userInput.contains('home boys') ||
      userInput.contains('home girls') ||
      userInput.contains('is everyone') ||
      userInput.contains('ba kae') ||
      userInput.contains('ile kae')) {
    responseTopic = 'searchingForLove';
  } else {
    // If no specific topic is found, use a generic response.
    responseTopic = 'default';
  }

  // Get a random response from the chosen topic or use a generic one.
  List<String> responses = topicResponses[responseTopic] ??
      [
        '🤔Hmm... tough one, couldnt find the right answer for you at the moment. Try something else'
      ];
  int index = Random().nextInt(responses.length);
  return responses[index];
}
