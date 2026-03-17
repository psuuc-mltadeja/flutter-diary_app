import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Welcome to Lumina Pages!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'A haven for emotional well-being in our fast-paced world. At Lumina Pages, we recognize the challenges of mental health, especially anxiety and depression, and present our app as a beacon of support and empowerment. \n\n  Our Mission:\n\n  At Lumina Pages, we are driven by a mission to provide practical and user-friendly tools that empower individuals to prioritize and maintain their emotional health. In the midst of modern life\'s demands, we aim to be a reliable companion on your journey to emotional well-being. \n\n Why Lumina Pages? \n\n Practical Solutions: We offer tangible solutions for everyday emotional challenges, ensuring accessible tools at your fingertips. \n\n User-Friendly Interface: Designed with simplicity, Lumina Pages is easy for anyone to navigate and incorporate into their daily routine. \n\n Holistic Approach: We believe in addressing emotional health comprehensively, providing a holistic approach that encompasses various aspects of mental well-being. \n\n Join Us in Prioritizing Emotional Well-being: \n\n Lumina Pages is more than an app; it is a commitment to yourself. Together, let us create a space where emotional health is valued, nurtured, and celebrated. Join us on this journey towards a brighter, emotionally resilient future. \n\n Your well-being matters, and Lumina Pages is here to illuminate your path. #LuminaWellBeing \n\n Developed By: Mark Lee T. Tadeja\n Designed By: Geraldine R. Nino\n\n',
                  style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,
                ),
                Center(child: Text('All Rights Reserved @2023\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'))
                // Add more information about your app here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
