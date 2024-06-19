import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/Tutor/NavigationBar.dart';  
import 'package:tutorinsa/pages/Common/profilepage.dart';// Assurez-vous que le chemin est correct

class TutorPostsPage extends StatefulWidget {
  const TutorPostsPage({super.key});

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPostsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  int _selectedIndex = 0;

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value.toLowerCase();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const ui.Color(0xFF5F67EA),
        automaticallyImplyLeading: false,
        title: const Text('Welcome, Amine'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Image(image: AssetImage("assets/images/avatar2.png")),
            tooltip: 'Profil de l\'utilisateur',
            onPressed: () {
              // Ajoutez votre logique ici pour ouvrir le profil de l'utilisateur
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un post...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            _updateSearchTerm(_searchController.text);
                          },
                        ),
                      ),
                      onSubmitted: _updateSearchTerm,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 0, top: 20.0),
              child: Text(
                'Les posts récents 🔥',
                style: TextStyle(
                  color: ui.Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPost('Aidez moi en Prog C 🙏🏼', 'Bonjour, je suis bloqué sur un exercice de Prog C de Mr ADELL, pouvez-vous m\'aider ?', 'assets/images/Buffer overflow.jpg'),
            _buildPost('Aidez moi en Java 🙏🏼', 'Bonjour, je suis bloqué sur un exercice de Java de Mr Eichler, pouvez-vous m\'aider ?', 'assets/images/java.png'),
            _buildPost('Aidez moi en RDM 🙏🏼', 'Bonjour, je suis bloqué sur un exercice de RDM de Mr Zeng, pouvez-vous m\'aider ?', 'assets/images/RDM.png'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar2(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildPost(String title, String content, String imagePath) {
    if (_searchTerm.isNotEmpty && !title.toLowerCase().contains(_searchTerm)) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: ui.Color.fromARGB(255, 87, 87, 87),
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: ui.Color.fromARGB(255, 87, 87, 87),
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: ui.Color.fromARGB(255, 255, 255, 255),
            offset: Offset(5, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 0),
                child: Image.asset(
                  imagePath,
                  width: 500,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
