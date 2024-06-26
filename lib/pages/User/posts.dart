import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/User/createpost.dart';
import 'package:tutorinsa/pages/Common/profilepage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:animations/animations.dart';
import 'package:tutorinsa/pages/Common/navigation_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  int _selectedIndex = 0;

  Future<ui.Image> _loadImage(BuildContext context) {
    final Completer<ui.Image> completer = Completer();
    final Image image =
        Image.network('https://img.youtube.com/vi/N_WgBU3S9W8/hqdefault.jpg');
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
              automaticallyImplyLeading: false,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LiveVideo()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: 0.7, // Adjust this value to control the crop
                            child: RawImage(
                              image: snapshot.data,
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
                              const SizedBox(width: 5),
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
                  _buildPost(
                      'Aidez moi en Prog C 🙏🏼',
                      'Bonjour, je suis bloqué sur un exercice de Prog C de Mr ADELL, pouvez-vous m\'aider ?',
                      'assets/images/Buffer overflow.jpg'),
                  _buildPost(
                      'Aidez moi en Java 🙏🏼',
                      'Bonjour, je suis bloqué sur un exercice de Java de Mr Eichler, pouvez-vous m\'aider ?',
                      'assets/images/java.png'),
                  _buildPost(
                      'Aidez moi en RDM 🙏🏼',
                      'Bonjour, je suis bloqué sur un exercice de RDM de Mr Zeng, pouvez-vous m\'aider ?',
                      'assets/images/RDM.png'),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar2(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
            floatingActionButton: OpenContainer(
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(28.0),
                ),
              ),
              closedColor: const Color(0xFF5F67EA),
              closedElevation: 6.0,
              transitionDuration: const Duration(milliseconds: 500),
              closedBuilder: (BuildContext context, VoidCallback openContainer) {
                return FloatingActionButton(
                  onPressed: openContainer,
                  backgroundColor: const Color(0xFF5F67EA),
                  child: const Icon(Icons.add, color: Colors.white),
                );
              },
              openBuilder: (BuildContext context, VoidCallback _) {
                return const CreatePost();
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        } else {
          return Container(
            color: const ui.Color.fromARGB(255, 20, 121, 121),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildPost(String title, String content, String imagePath) {
    if (_searchTerm.isNotEmpty && !title.toLowerCase().contains(_searchTerm)) {
      return const Center(
        child: Text(
          'Aucun post trouvé',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
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

class LiveVideo extends StatelessWidget {
  const LiveVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Video'),
      ),
      body: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: 'N_WgBU3S9W8',
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
