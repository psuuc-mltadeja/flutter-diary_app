import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:luminapages/screens/view_screen.dart';
import 'package:luminapages/screens/add_details.dart';
class MonthDetailScreen extends StatefulWidget {
  final int month;
  final String title;
  final String imagePath;

  MonthDetailScreen({
    required this.month,
    required this.title,
    required this.imagePath,
  });

  @override
  _MonthDetailScreenState createState() => _MonthDetailScreenState();
}

class _MonthDetailScreenState extends State<MonthDetailScreen> {
  List<Map<String, dynamic>> detailsList = [];

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    final Database database = await _openDatabase();

    final List<Map<String, dynamic>> details = await database.query(
      'details',
      where: 'month = ?',
      whereArgs: [widget.month],
    );

    await database.close();

    setState(() {
      detailsList = details;
    });
  }

  Future<Database> _openDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'app_database.db');

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE details (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, date TEXT, month INTEGER)',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              final Map<String, dynamic>? details = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDetailsScreen(month: widget.month),
                ),
              );
              if (details != null) {
                await _saveDetails(details);
                await _loadDetails();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            // Use a Container to add some opacity to the background image
            color: Colors.black.withOpacity(0.5),
            child: ListView.builder(
              itemCount: detailsList.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> details = detailsList[index];
                final formattedDate = details['date'] != null
                    ? DateTime.parse(details['date']!)
                        .toLocal()
                        .toString()
                        .split(' ')[0]
                    : 'N/A';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewDetailsScreen(details: details),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                            onPressed: () async {
                              final Map<String, dynamic>? editedDetails =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddDetailsScreen(
                                    month: widget.month,
                                    existingDetails: details,
                                  ),
                                ),
                              );

                              if (editedDetails != null) {
                                await _updateDetails(
                                    details['id'], editedDetails);
                                await _loadDetails();
                              }
                            },
                          ),
                        ),
                        title: Text('Title: ${details['title']}'),
                        subtitle: Text('Date: $formattedDate'),
                        trailing: IconButton(
                          onPressed: () async {
                            bool userConfirmed =
                                await _showDeleteConfirmationDialog(
                                    details['id'], context);

                            if (userConfirmed) {
                              await _deleteDetails(details['id']);
                              await _loadDetails();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Item deleted'),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
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

  Future<bool> _showDeleteConfirmationDialog(
      int id, BuildContext context) async {
    bool confirmDelete = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Confirm Deletion')),
          content: Text('Are you sure you want to delete this content?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      confirmDelete = value ?? false;
    });

    return confirmDelete;
  }

  Future<void> _deleteDetails(int id) async {
    final Database database = await _openDatabase();

    await database.delete(
      'details',
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

  Future<void> _saveDetails(Map<String, dynamic> details) async {
    final Database database = await _openDatabase();

    await database.insert(
      'details',
      {
        'title': details['title'],
        'body': details['body'],
        'date': details['date'],
        'month': widget.month,
      },
    );

    await database.close();
  }

  Future<void> _updateDetails(int id, Map<String, dynamic> details) async {
    final Database database = await _openDatabase();

    await database.update(
      'details',
      details,
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }
}
