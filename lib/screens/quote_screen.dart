import 'package:flutter/material.dart';
import 'package:luminapages/screens/story_screen.dart';

class StoriesScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/quote_1.jpg',
    'assets/images/quote_2.jpg',
    'assets/images/quote_3.jpg',
    'assets/images/quote_4.jpg',
    'assets/images/quote_6.jpg',
    'assets/images/quote_7.jpg',
    'assets/images/quote_8.jpg',
    'assets/images/quote_9.jpg',
    'assets/images/quote_10.jpg',
    'assets/images/quote_11.jpg',
  ];

  final List<String> quotes = [
    'Getting strong each day',
    'Life is not about waiting for the storm to pass, it is about learning to dance in the rain!',
    'Live int the moment',
    'Moving forward in the silent high',
    'Love is not something you look for, love is something you become',
    'Progress not perfection',
    'If I could dream at all, it would be about you. I am not ashamed of it',
    'Life is too short to listen to bad music',
    'It is okay to be okay',
    'Do not lose hope nor be sad',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
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
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _navigateToDetailScreen(context, images[index], quotes[index]);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(images[index], fit: BoxFit.cover),
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

  void _navigateToDetailScreen(BuildContext context, String image, String quote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailScreen(image: image, quote: quote),
      ),
    );
  }
}
