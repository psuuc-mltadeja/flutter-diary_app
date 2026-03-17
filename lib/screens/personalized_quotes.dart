import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:luminapages/screens/add_quotes.dart';

class PersonalizedQuotesListScreen extends StatefulWidget {
  @override
  _PersonalizedQuotesListScreenState createState() =>
      _PersonalizedQuotesListScreenState();
}

class _PersonalizedQuotesListScreenState
    extends State<PersonalizedQuotesListScreen> {
  List<Map<String, dynamic>> personalizedQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadPersonalizedQuotes();
  }

  Future<void> _loadPersonalizedQuotes() async {
    final Database database = await _openDatabase();

    final List<Map<String, dynamic>> quotes = await database.query(
      'personalized_quotes',
    );

    await database.close();

    setState(() {
      personalizedQuotes = quotes;
    });
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

  Future<void> _deleteQuote(int id) async {
    final Database database = await _openDatabase();

    await database.delete(
      'personalized_quotes',
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalized Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
   
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPersonalizedQuoteScreen(),
                ),
              ).then((value) {
             
                _loadPersonalizedQuotes();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
         
          Image.asset(
            'assets/images/background.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: personalizedQuotes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xFFFFE5B4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                personalizedQuotes[index]['quote'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit_document,
                                  color: Colors.amber),
                              onPressed: () {
                            
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddPersonalizedQuoteScreen(
                                      initialQuote: personalizedQuotes[index]
                                          ['quote'],
                                    ),
                                  ),
                                ).then((value) {
                                
                                  _loadPersonalizedQuotes();
                                });
                              },
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_forever_rounded,
                                  color: Colors.red),
                              onPressed: () async {
                           
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(child: Text('Confirm Deletion')),
                                      content: Text(
                                        'Are you sure you want to delete this quote?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmDelete == true) {
                                  await _deleteQuote(
                                      personalizedQuotes[index]['id'] as int);
                            
                                  _loadPersonalizedQuotes();
                                }
                              },
                            ),
                          ],
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
}
