// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  // ? specify if a variable can be null
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API User List'),
        backgroundColor: Color.fromARGB(255, 220, 204, 242),
        centerTitle: true,
  
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Note- Click on Refresh Button to get the user list',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final email = user['email'];
                  final imageUrl = user['picture']['thumbnail'];
                  final name = user['name']['first'];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(imageUrl),
                    ),
                    title: Text(
                      email,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                
                      ),
                    ),
                    subtitle: Text(
                      name,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
       
        child: const Icon(
          Icons.update,
        ),
      ),
    );
  }

  void fetchData() async {
    print('🔰 Fetching Started!');
    const url = 'https://randomuser.me/api/?results=30';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('🚫 Fetching executed!');
  }
}

  // users = json['body']; ERROR - THIS WILL SURELY GENERATE AN ERROR WHY?
      //Here is the reason for an error -
      /*In the API response, the results key is used to hold the list of users returned by the API. The body key is not present in the response.
      So, when you decode the JSON response using jsonDecode(body), the resulting object is a map containing a single key results, which holds the list of users.
      Therefore, you should use json['results'] to get the list of users, instead of json['body'].*/