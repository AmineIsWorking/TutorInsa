import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('Category 1'),
                  onTap: () {
                    // Navigate to category 1
                  },
                ),
                ListTile(
                  title: const Text('Category 2'),
                  onTap: () {
                    // Navigate to category 2
                  },
                ),
                ListTile(
                  title: const Text('Category 3'),
                  onTap: () {
                    // Navigate to category 3
                  },
                ),
                // Add more categories as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}