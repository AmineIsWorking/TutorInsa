import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF5F67EA),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigate to 1A
                  },
                  child: const Card(
                    child: Center(child: Text('1A')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 2A PO STI
                  },
                  child: const Card(
                    child: Center(child: Text('2A PO STI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 2A PO MRI
                  },
                  child: const Card(
                    child: Center(child: Text('2A PO MRI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 2A PO GSI
                  },
                  child: const Card(
                    child: Center(child: Text('2A PO GSI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 3A ERE
                  },
                  child: const Card(
                    child: Center(child: Text('3A ERE')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 3A STI
                  },
                  child: const Card(
                    child: Center(child: Text('3A STI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 3A MRI
                  },
                  child: const Card(
                    child: Center(child: Text('3A MRI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 4A STI
                  },
                  child: const Card(
                    child: Center(child: Text('4A STI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 4A MRI
                  },
                  child: const Card(
                    child: Center(child: Text('4A MRI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 4A ERE
                  },
                  child: const Card(
                    child: Center(child: Text('4A ERE')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 5A STI
                  },
                  child: const Card(
                    child: Center(child: Text('5A STI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 5A MRI
                  },
                  child: const Card(
                    child: Center(child: Text('5A MRI')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to 5A ERE
                  },
                  child: const Card(
                    child: Center(child: Text('5A ERE')),
                  ),
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