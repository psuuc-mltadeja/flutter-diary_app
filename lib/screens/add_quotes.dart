import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddPersonalizedQuoteScreen extends StatefulWidget {
  final String? initialQuote;

  AddPersonalizedQuoteScreen({this.initialQuote});

  @override
  _AddPersonalizedQuoteScreenState createState() =>
      _AddPersonalizedQuoteScreenState();
}

class _AddPersonalizedQuoteScreenState
    extends State<AddPersonalizedQuoteScreen> {
  TextEditingController quoteController = TextEditingController();
  int wordCount = 0;
  int maxWordLimit = 50;

  @override
  void initState() {
    super.initState();

    // Set the initial value if provided
    quoteController.text = widget.initialQuote ?? '';
    // Calculate initial word count
    wordCount = _countWords(quoteController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialQuote != null
            ? 'Edit Personalized Quote'
            : 'Add Personalized Quote'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(child: Text("Write your own motivational quotes!")),
                Center(
                    child: Text(
                  'Maximum of 50 words',
                  style: TextStyle(fontSize: 10),
                )),
                TextField(
                  controller: quoteController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (text) {
                    // Update word count whenever the text changes
                    setState(() {
                      wordCount = _countWords(text);
                    });

                    // Enforce word limit
                    if (wordCount > maxWordLimit) {
                      // Trim excess words
                      quoteController.text =
                          _truncateWords(text, maxWordLimit);
                      // Move the cursor to the end of the text
                      quoteController.selection = TextSelection.fromPosition(
                        TextPosition(offset: quoteController.text.length),
                      );
                    }
                  },
                  decoration: InputDecoration(labelText: 'Quote'),
                ),
                SizedBox(height: 16),
                Text('$wordCount / $maxWordLimit words'),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: wordCount > 0 && wordCount <= maxWordLimit
                            ? () async {
                                // Save or update the quote in the database or perform any other necessary action
                                String quote = quoteController.text;

                                if (quote.isNotEmpty) {
                                  if (widget.initialQuote != null) {
                                    // If editing, update the existing quote
                                    await _updateQuote(quote);
                                  } else {
                                    // If adding, save a new quote
                                    await _saveQuote(quote);
                                  }
                                }

                                Navigator.pop(context);
                              }
                            : null,
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to count words in a string
  int _countWords(String text) {
    List<String> words = text.trim().split(RegExp(r'\s+'));
    return words.length;
  }

  // Helper function to truncate words in a string to a specified limit
  String _truncateWords(String text, int limit) {
    List<String> words = text.trim().split(RegExp(r'\s+'));
    return words.take(limit).join(' ');
  }

  Future<void> _saveQuote(String quote) async {
    final Database database = await _openDatabase();

    await database.insert(
      'personalized_quotes',
      {'quote': quote},
    );

    await database.close();
  }

  Future<void> _updateQuote(String quote) async {
    final Database database = await _openDatabase();

    await database.update(
      'personalized_quotes',
      {'quote': quote},
      where: 'quote = ?',
      whereArgs: [widget.initialQuote],
    );

    await database.close();
  }

  Future<Database> _openDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'app_data.db');

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS personalized_quotes (id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT)',
      );
    });
  }
}