import 'package:flutter/material.dart';
import 'package:luminapages/screens/personalized_quotes.dart';
import 'package:luminapages/screens/about_us.dart';
import 'package:luminapages/screens/month_screen.dart';
import 'package:luminapages/screens/quote_screen.dart';
import 'dart:math';

class MyHomePage extends StatelessWidget {
  List<Map<String, dynamic>> deletedItems = [];
  final List<String> monthImages = [
    'assets/images/jan.jpg',
    'assets/images/feb.jpg',
    'assets/images/mar.jpg',
    'assets/images/april.jpg',
    'assets/images/may.jpg',
    'assets/images/jun.jpg',
    'assets/images/jul.jpg',
    'assets/images/aug.jpg',
    'assets/images/sep.jpg',
    'assets/images/oct.jpg',
    'assets/images/nov.jpg',
    'assets/images/dec.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lumina Pages'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.lightbulb,
              color: Colors.amber,
            ),
            onPressed: () => _showRandomQuote(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFFE5B4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lumina Pages',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  Spacer(flex: 10),
                  Text(
                    'Words Whispered, Emotions Captured: Your Digital Sanctuary for Daily Reflections.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.book_online_rounded, color: Colors.amber),
                  SizedBox(width: 10),
                  Text('Quotes'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoriesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.edit_document, color: Colors.amber),
                  SizedBox(width: 10),
                  Text('Personalized Quotes'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalizedQuotesListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.info, color: Colors.amber),
                  SizedBox(width: 10),
                  Text('About Us'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final monthName = _getMonthName(index + 1);
                final imagePath = monthImages[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonthDetailScreen(
                          month: index + 1,
                          title: monthName,
                          imagePath: imagePath,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  void _showRandomQuote(BuildContext context) {
    final int randomIndex = Random().nextInt(quotes.length);
    final String randomQuote = quotes[randomIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Random Quote')),
          content: Text(randomQuote),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Center(
                child: Text(
                  'Thanks!',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

List<String> quotes = [
  'With the new day comes new strength and new thoughts.\n - Eleanor Roosevelt',
  'It does not matter how slowly you go as long as you do not stop.\n - Confucius',
  'It always seems impossible until it is done.\n - Nelson Mandela',
  'If you are going through hell, keep going.\n - Winston Churchill',
  'Good, better, best. Never let it rest. Til your good is better and your better is best.\n - St. Jerome',
  'Everything has its wonders, even darkness and silence, and I learn, whatever state I may be in, therein to be content.\n - Helen Keller',
  'The most worth-while thing is to try to put happiness into the lives of others.\n - Robert Baden-Powell',
  'Be happy for this moment. This moment is your life.\n - Omar Khayyam',
  'Our prime purpose in this life is to help others. And if you cannot help them, at least do not hurt them.\n - Dalai Lama',
  'It is health that is real wealth and not pieces of gold and silver.\n - Mahatma Gandhi'
];
