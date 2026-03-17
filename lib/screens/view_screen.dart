import 'package:flutter/material.dart';

class ViewDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> details;

  ViewDetailsScreen({required this.details});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateTime.parse(details['date']).toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(details['title'])),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '${details['title']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('$formattedDate', style: TextStyle(fontSize: 10),),
                  SizedBox(height: 10,),
                  Text(
                    '  ${details['body']}\n\n\n\n\n\n\n\n\n\n\n',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
