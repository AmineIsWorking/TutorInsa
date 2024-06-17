import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<String> _tags = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _selectedSubject;
  CollectionReference postsRef = FirebaseFirestore.instance.collection('Posts');

  // Liste prédéfinie de matières
  final List<String> _subjects = [
    'Mathématiques',
    'Physique',
    'Chimie',
    'Biologie',
    'Informatique',
    'Histoire',
    'Géographie',
    'Anglais',
    'Français',
    'Espagnol',
    // Ajoutez plus de matières si nécessaire
  ];

  void _addTag(String tag) {
    setState(() {
      _tags.add(tag);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _publishPost() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Veuillez remplir tous les champs.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String imageUrl = '';

    if (_image != null) {
      // Uploader l'image vers Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('images').child('${DateTime.now()}.jpg');
      UploadTask uploadTask = storageRef.putFile(File(_image!.path));
      await uploadTask.whenComplete(() async {
        imageUrl = await storageRef.getDownloadURL();
      });
    }

    // Enregistrer le post dans Firestore
    await postsRef.add({
      'Titre': _titleController.text,
      'Contenu': _contentController.text,
      'Tags': _tags,
      'Image': imageUrl,
      'Timestamp': FieldValue.serverTimestamp(),
    });

    // Fermer l'écran de création de post
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Créer un post'),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Titre',
                      hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Écrire un post...',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 16),
                  if (_image != null)
                    Stack(
                      children: [
                        Image.file(
                          File(_image!.path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            color: Colors.black54,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    children: _tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Icon(Icons.label),
                      const SizedBox(width: 8),
                      Container(
                        width: 171.0,
                        child: DropdownButton<String>(
                          value: _selectedSubject,
                          hint: const Text('Ajoutez une matière'),
                          items: _subjects.map((subject) {
                            return DropdownMenuItem<String>(
                              value: subject,
                              child: Text(subject),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSubject = value;
                              if (value != null) {
                                _addTag(value);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 90.0), // Ajoutez cette ligne
                      IconButton(
                        icon: const Icon(Icons.image),
                        color: const Color(0xFF5F67EA),
                        iconSize: 40.0,
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: ElevatedButton(
                    onPressed: _publishPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5F67EA),
                    ),
                    child: const Text(
                      'Publier',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
