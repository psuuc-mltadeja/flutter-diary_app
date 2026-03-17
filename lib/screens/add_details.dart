import 'package:flutter/material.dart';

class AddDetailsScreen extends StatefulWidget {
  final int month;
  final Map<String, dynamic>? existingDetails;

  AddDetailsScreen({required this.month, this.existingDetails});

  @override
  _AddDetailsScreenState createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Initialize with the current date

  @override
  void initState() {
    super.initState();

    // Check if existingDetails is provided (editing mode)
    if (widget.existingDetails != null) {
      // Populate fields with existing data
      titleController.text = widget.existingDetails!['title'];
      bodyController.text = widget.existingDetails!['body'];

      // Parse and set the existing date
      final existingDate =
          DateTime.parse(widget.existingDetails!['date']!).toLocal();
      setState(() {
        selectedDate = existingDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Writings'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  "Capturing Moments, Unleashing Thoughts: Your Personal Diary Journey.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: bodyController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(labelText: 'Your Story'),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Creation Date: ${selectedDate.toLocal()}'
                            .split(' ')[0],
                      ),
                      // Remove IconButton for non-editable date
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // Save data to the database
                    final Map<String, dynamic> details = {
                      'title': titleController.text,
                      'body': bodyController.text,
                      'date': selectedDate.toLocal().toString(),
                    };

                    // Navigate back and send data to the previous screen
                    Navigator.pop(context, details);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
