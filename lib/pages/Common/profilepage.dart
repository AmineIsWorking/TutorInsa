import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorinsa/pages/Common/home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  bool isEditingName = false;
  bool isEditingLastName = false;
  bool isEditingInsaAddress = false;
  bool isEditingFiliere = false;
  bool isEditingAnnee = false;
  bool isEditingPassword = false;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  String name = 'John';
  String lastName = 'Doe';
  String insaAddress = 'insa@example.com';
  String filiere = 'Computer Science';
  String annee = '3rd Year';
  String password = '********';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF5F67EA),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image == null
                            ? const AssetImage('assets/images/nopicture.png')
                            : FileImage(_image!) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: getImage,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildEditableField('Nom', name, isEditingName, (value) {
                  setState(() {
                    name = value;
                  });
                }, () {
                  setState(() {
                    isEditingName = !isEditingName;
                  });
                }),
                const SizedBox(height: 16),
                _buildEditableField('Prénom', lastName, isEditingLastName, (value) {
                  setState(() {
                    lastName = value;
                  });
                }, () {
                  setState(() {
                    isEditingLastName = !isEditingLastName;
                  });
                }),
                const SizedBox(height: 16),
                _buildEditableField('Adresse INSA', insaAddress, isEditingInsaAddress, (value) {
                  setState(() {
                    insaAddress = value;
                  });
                }, () {
                  setState(() {
                    isEditingInsaAddress = !isEditingInsaAddress;
                  });
                }),
                const SizedBox(height: 16),
                _buildEditableField('Filière', filiere, isEditingFiliere, (value) {
                  setState(() {
                    filiere = value;
                  });
                }, () {
                  setState(() {
                    isEditingFiliere = !isEditingFiliere;
                  });
                }),
                const SizedBox(height: 16),
                _buildEditableField('Année', annee, isEditingAnnee, (value) {
                  setState(() {
                    annee = value;
                  });
                }, () {
                  setState(() {
                    isEditingAnnee = !isEditingAnnee;
                  });
                }),
                const SizedBox(height: 16),
                _buildEditableField('Mot de passe', password, isEditingPassword, (value) {
                  setState(() {
                    password = value;
                  });
                }, () {
                  setState(() {
                    isEditingPassword = !isEditingPassword;
                  });
                }, isPassword: true),
                const SizedBox(height: 24),
                const Divider(),
                ListTile(
                  title: const Text('Déconnexion'),
                  leading: const Icon(Icons.logout, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Supprimer le compte'),
                  leading: const Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    // Delete the user's account
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, String value, bool isEditing, ValueChanged<String> onChanged, VoidCallback onEditPressed, {bool isPassword = false}) {
    return Row(
      children: [
        Expanded(
          child: isEditing
              ? SizedBox(
                  width: 10, // Définissez la largeur souhaitée ici
                  child: TextFormField(
                    initialValue: value,
                    decoration: InputDecoration(
                      labelText: label,
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: isPassword,
                    onChanged: onChanged,
                  ),
                )
              : SizedBox(
                  width: 50, // Définissez la largeur souhaitée ici
                  child: ListTile(
                    subtitle: Text(label),
                    title: Text(value),
                  ),
                ),
        ),
        const SizedBox(width: 10), // Ajout d'un espacement fixe entre le champ et le bouton
        TextButton(
          onPressed: onEditPressed,
          child: Text(
            isEditing ? 'Sauvegarder' : 'Changer',
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
