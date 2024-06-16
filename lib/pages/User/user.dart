import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  Future<ui.Image> _loadImage(BuildContext context) {
    final Completer<ui.Image> completer = Completer();
    final Image image =
        Image.network('https://img.youtube.com/vi/OXmnrfj2ERc/hqdefault.jpg');
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          if (!completer.isCompleted) {
            completer.complete(image.image);
          }
        },
      ),
    );
    return completer.future;
  }

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _loadImage(context),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const ui.Color(0xFF5F67EA),
              automaticallyImplyLeading: true,
              title: const Text('Welcome, Amine'),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Image(
                      image: AssetImage("assets/images/avatar2.png")),
                  tooltip: 'Profil de l\'utilisateur',
                  onPressed: () {
                    // Ajoutez votre logique ici pour ouvrir le profil de l'utilisateur
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoPage()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor:
                                0.7, // Adjust this value to control the crop
                            child: RawImage(
                              image: snapshot
                                  .data, // Utilisez RawImage pour afficher l'image dart:ui.Image
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      5), // Espacement entre le point et le texte
                              const Text(
                                'En Live',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                icon: Icon(Icons.search),
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
            bottomNavigationBar: NavigationBar(),
          );
        } else {
          return Container(
              color: const ui.Color.fromARGB(255, 20, 121, 121),
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
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

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Video'),
      ),
      body: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: 'OXmnrfj2ERc',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
      ),
    );
  }
}

Widget NavigationBar() {
  return Container(
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xFF5F67EA),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.grey.withOpacity(0.7),
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              label: 'Accueil',
              icon: Icon(
                Icons.home_rounded,
                size: 50,
              ),
            ),
            BottomNavigationBarItem(
              label: "Posts",
              icon: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.more_horiz_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Vidéos",
              icon: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "RDV",
              icon: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
