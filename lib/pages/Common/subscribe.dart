import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:confetti/confetti.dart';
import 'package:tutorinsa/pages/User/posts.dart';

class SubscribePage1 extends StatefulWidget {
  const SubscribePage1({super.key});

  @override
  _SubscribePage1State createState() => _SubscribePage1State();
}

class _SubscribePage1State extends State<SubscribePage1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Comment t\'appelles-tu ?',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(
                      labelText: 'Prénom',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre prénom';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: const SubscribePage1(),
                            child: SubscribePage2(
                              nom: _nomController.text,
                              prenom: _prenomController.text,
                            ),
                            duration: const Duration(milliseconds: 400),
                          ),
                        );
                      }
                    },
                    child: const Text('Suivant'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SubscribePage2 extends StatefulWidget {
  final String nom;
  final String prenom;

  const SubscribePage2({super.key, required this.nom, required this.prenom});

  @override
  _SubscribePage2State createState() => _SubscribePage2State();
}

class _SubscribePage2State extends State<SubscribePage2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _anneeController = TextEditingController();
  final TextEditingController _filiereController = TextEditingController();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Quelle est ta formation ?',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _anneeController,
                    decoration: const InputDecoration(
                      labelText: 'Année',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre année';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _filiereController,
                    decoration: const InputDecoration(
                      labelText: 'Filière',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre filière';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: SubscribePage2(
                              nom: widget.nom,
                              prenom: widget.prenom,
                            ),
                            child: SubscribePage3(
                              nom: widget.nom,
                              prenom: widget.prenom,
                              annee: _anneeController.text,
                              filiere: _filiereController.text,
                            ),
                            duration: const Duration(milliseconds: 400),
                          ),
                        );
                      }
                    },
                    child: const Text('Suivant'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubscribePage3 extends StatefulWidget {
  final String nom;
  final String prenom;
  final String annee;
  final String filiere;

  const SubscribePage3({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.annee,
    required this.filiere,
  }) : super(key: key);

  @override
  _SubscribePage3State createState() => _SubscribePage3State();
}

class _SubscribePage3State extends State<SubscribePage3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Corrected RegExp pattern for email validation
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );


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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Entre tes identifiants INSA',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email INSA',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email INSA';
                      }
                      if (!_emailRegExp.hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(57, 61, 37, 168),
                      filled: true,
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      // Add additional validation logic for password strength if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: this.widget,
                            child: SubscribePage4(
                              nom: widget.nom,
                              prenom: widget.prenom,
                              annee: widget.annee,
                              filiere: widget.filiere,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                            duration: const Duration(milliseconds: 400),
                          ),
                        );
                      }
                    },
                    child: const Text('Suivant'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SubscribePage4 extends StatefulWidget {
  final String nom;
  final String prenom;
  final String annee;
  final String filiere;
  final String email;
  final String password;

  const SubscribePage4(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.annee,
      required this.filiere,
      required this.email,
      required this.password});

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
                    ? const Icon(Icons.account_circle,
                        size: 100, color: Colors.white)
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
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
                          child: Icon(Icons.add_a_photo_rounded,
                              color: Color.fromARGB(255, 59, 70, 150)),
                        ),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      color: Colors.white,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: SubscribePage4(
                              nom: widget.nom,
                              prenom: widget.prenom,
                              annee: widget.annee,
                              filiere: widget.filiere,
                              email: widget.email,
                              password: widget.password,
                            ),
                            child: SubscribePage5(
                              nom: widget.nom,
                              prenom: widget.prenom,
                              annee: widget.annee,
                              filiere: widget.filiere,
                              email: widget.email,
                              password: widget.password,
                              profileImage: _image,
                            ),
                            duration: const Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: const Text('Suivant'),
                    ),
                    IconButton(
                      icon: Transform.scale(
                        scale: 1.3,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.image_rounded,
                              color: Color.fromARGB(255, 59, 70, 150)),
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
  final String nom;
  final String prenom;
  final String annee;
  final String filiere;
  final String email;
  final String password;
  final File? profileImage;

  const SubscribePage5({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.annee,
    required this.filiere,
    required this.email,
    required this.password,
    this.profileImage,
  }) : super(key: key);

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
                        child: SubscribePage6(
                          nom: nom,
                          prenom: prenom,
                          annee: annee,
                          filiere: filiere,
                          email: email,
                          password: password,
                          profileImage: profileImage,
                          isTuteur: true,
                        ),
                        duration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: const Text('Tuteur', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        child: CongratulationsPage(
                          nom: nom,
                          prenom: prenom,
                          annee: annee,
                          filiere: filiere,
                          email: email,
                          password: password,
                          profileImage: profileImage,
                          isTuteur: false,
                          selectedMatieres: [],
                        ),
                        duration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: const Text('Etudiant', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
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
  final String nom;
  final String prenom;
  final String annee;
  final String filiere;
  final String email;
  final String password;
  final File? profileImage;
  final bool isTuteur;
  final List<String> selectedMatieres; // Sera null si l'utilisateur n'est pas un tuteur

  const CongratulationsPage({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.annee,
    required this.filiere,
    required this.email,
    required this.password,
    this.profileImage,
    required this.isTuteur,
    required this.selectedMatieres, // Initialisation de la variable
  }) : super(key: key);

  @override
  _CongratulationsPageState createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  late ConfettiController _confettiController;

  void printDetails() {
    print('Nom: ${widget.nom}');
    print('Prénom: ${widget.prenom}');
    print('Année: ${widget.annee}');
    print('Filière: ${widget.filiere}');
    print('Email: ${widget.email}');
    print('Password: ${widget.password}');
    print('ProfileImage: ${widget.profileImage}');
    print('isTuteur: ${widget.isTuteur}');
    print('SelectedMatieres: ${widget.selectedMatieres}');
  }

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
    Timer(const Duration(seconds: 3), () {
      _confettiController.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserPage()),
      );
    });
    printDetails();
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
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Text(
                    'Bienvenue sur TutorInsa !',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
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
  final String nom;
  final String prenom;
  final String annee;
  final String filiere;
  final String email;
  final String password;
  final File? profileImage;
  final bool isTuteur; // Nouvelle variable booléenne

  const SubscribePage6({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.annee,
    required this.filiere,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.isTuteur, // Initialisation de la variable
  }) : super(key: key);

  @override
  _SubscribePage6State createState() => _SubscribePage6State();
}

class _SubscribePage6State extends State<SubscribePage6> {
  List<String> matieres = [
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

  List<bool> isSelected = List<bool>.generate(10, (index) => false);
  List<String> selectedMatieres = []; // List to store selected subjects

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Dans quelles matières veux-tu aider ?',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: matieres.asMap().entries.map((entry) {
                          int index = entry.key;
                          String matiere = entry.value;
                          return ChoiceChip(
                            label: Text(
                              matiere,
                              style: const TextStyle(color: Colors.white),
                            ),
                            selected: isSelected[index],
                            onSelected: (bool selected) {
                              setState(() {
                                isSelected[index] = selected;
                                if (selected) {
                                  selectedMatieres.add(
                                      matiere); // Add subject to selected list
                                } else {
                                  selectedMatieres.remove(
                                      matiere); // Remove subject from selected list
                                }
                              });
                            },
                            backgroundColor: isSelected[index]
                                ? Colors.blue
                                : const Color.fromARGB(255, 59, 70, 150),
                            selectedColor: Colors.blue,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedMatieres.isNotEmpty) {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: this.widget,
                              child: CongratulationsPage(
                                nom: widget.nom,
                                prenom: widget.prenom,
                                annee: widget.annee,
                                filiere: widget.filiere,
                                email: widget.email,
                                password: widget.password,
                                profileImage: widget.profileImage,
                                isTuteur: widget.isTuteur,
                                selectedMatieres:
                                    selectedMatieres, // Pass selected subjects to CongratulationsPage
                              ),
                              duration: const Duration(milliseconds: 400),
                            ),
                          );
                        } else {
                          if (selectedMatieres.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Veuillez choisir au moins une matière.'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Suivant'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

