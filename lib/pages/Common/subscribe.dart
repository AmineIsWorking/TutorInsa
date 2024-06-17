import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:confetti/confetti.dart';
import 'package:tutorinsa/pages/User/posts.dart';

class SubscribePage1 extends StatelessWidget {
  const SubscribePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Comment t\'appelles-tu ?',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        child: const SubscribePage2(),
                        duration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: const Text('Suivant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscribePage2 extends StatelessWidget {
  const SubscribePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Quelle est ta formation ?',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Année',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Filière',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        child: const SubscribePage3(),
                        duration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: const Text('Suivant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SubscribePage3 extends StatelessWidget {
  const SubscribePage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Entre tes identifiants INSA',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email INSA',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  obscureText: true, // Ajoutez cette ligne pour masquer l'entrée de l'utilisateur
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        child: const SubscribePage4(),
                        duration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: const Text('Suivant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscribePage4 extends StatefulWidget {
  const SubscribePage4({super.key});

  @override
  _SubscribePage4State createState() => _SubscribePage4State();
}

class _SubscribePage4State extends State<SubscribePage4> {
  File? _image;

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Souris pour une photo de profil !',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 50),
                _image == null
                    ? const Icon(Icons.account_circle, size: 100, color: Colors.white)
                    : SizedBox(
                        height: 200, // Définir la hauteur
                        width: 200, // Définir la largeur
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover, // Utiliser BoxFit.cover pour s'assurer que l'image couvre tout l'espace disponible
                        ),
                      ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Transform.scale(
                        scale: 1.3,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add_a_photo_rounded, color: Color.fromARGB(255, 59, 70, 150)),
                        ),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0), // Ajoutez du padding ici
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: const SubscribePage4(),
                                child: const SubscribePage5(),
                                duration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return Colors.grey; // Couleur de fond lorsque le bouton est désactivé
                                }
                                return Colors.white; // Couleur de fond par défaut
                              },
                            ),
                            foregroundColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                return states.contains(WidgetState.disabled)
                                    ? Colors.black54 // Couleur du texte lorsque le bouton est désactivé
                                    : const Color.fromARGB(255, 59, 70, 150); // Couleur du texte par défaut
                              },
                            ),
                          ),
                          child: const Text('Suivant'),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Transform.scale(
                        scale: 1.3,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.image_rounded, color: Color.fromARGB(255, 59, 70, 150)),
                        ),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscribePage5 extends StatelessWidget {
  const SubscribePage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Tu t\'inscrit en tant que :',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 170),
                ElevatedButton(
                  onPressed: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: this,
                                child: SubscribePage6(),
                                duration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                  child: Text('Tuteur', style: TextStyle(fontSize: 20)), // change la taille de la police ici
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60), // change la taille ici
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                childCurrent: this,
                                child: CongratulationsPage(),
                                duration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                  child: Text('Etudiant', style: TextStyle(fontSize: 20)), // change la taille de la police ici
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60), // change la taille ici
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({Key? key}) : super(key: key);

  @override
  _CongratulationsPageState createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  late ConfettiController _confettiController;
  bool isPlaying = false;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _confettiController.play();
    Timer(Duration(seconds: 3), () {
      _confettiController.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserPage()),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.1,
              numberOfParticles: 5,
              maxBlastForce: 10,
              minBlastForce: 1,
              gravity: 0.4,
            ),
            const Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Félicitations !',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Text(
                    'Bienvenue sur TutorInsa',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SubscribePage6 extends StatefulWidget {
  const SubscribePage6({Key? key}) : super(key: key);

  @override
  _SubscribePage6State createState() => _SubscribePage6State();
}

class _SubscribePage6State extends State<SubscribePage6> {
  final List<String> matieres = [
    'Mathématiques',
    'Physique',
    'Chimie',
    'Biologie',
    'Histoire',
    'Géographie',
    'Français',
    'Anglais',
    'Informatique',
    'Philosophie',
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 28, 68),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Quelles matières veux-tu tutorer ?',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Tapez ici',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(57, 61, 37, 168),
                    filled: true,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: matieres.map((matiere) {
                        return Chip(
                          label: Text(
                            matiere,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: const Color.fromARGB(255, 59, 70, 150),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ajoutez votre logique de navigation ici
                    },
                    child: const Text('Suivant'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
