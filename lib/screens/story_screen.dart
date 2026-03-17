import 'package:flutter/material.dart';
import 'package:luminapages/screens/quote_screen.dart';

class StoryDetailScreen extends StatelessWidget {
  final String image;
  final String quote;

  StoryDetailScreen({required this.image, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg', // Replace with your image path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
      
            children: [
              SizedBox(height: 80), // Adjust the spacing from the top as needed
              Text(
                'A short quote for you.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(image),
              ),
              SizedBox(height: 10),
            
             
            ],
          ),
        ],
      ),
    );
  }
}
