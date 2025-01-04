import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BasicTutorialsScreen extends StatefulWidget {
  @override
  _BasicTutorialsScreenState createState() => _BasicTutorialsScreenState();
}

class _BasicTutorialsScreenState extends State<BasicTutorialsScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> tutorials = [];

  @override
  void initState() {
    super.initState();
    _fetchTutorials();
  }

  Future<void> _fetchTutorials() async {
    try {
      // Fetch data from "basic_tutorials" node
      DatabaseEvent event = await _database.child('basic_tutorials').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        setState(() {
          tutorials = data.entries.map((entry) {
            Map<String, dynamic> tutorialData =
                Map<String, dynamic>.from(entry.value);
            return {
              'title': tutorialData['title'] ?? 'No Title',
              'content': tutorialData['content'] ?? 'No Content',
              'created_at': tutorialData['created_at'] ?? '',
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching tutorials: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hướng dẫn cơ bản'),
      ),
      body: tutorials.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tutorials.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(tutorials[index]['title']!),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tutorials[index]['content']!),
                          SizedBox(height: 10),
                          Text(
                            'Created At: ${tutorials[index]['created_at']}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
