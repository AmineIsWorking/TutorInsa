import 'package:flutter/material.dart';

class RDVPage extends StatefulWidget {
  const RDVPage({Key? key}) : super(key: key);

  @override
  _RDVPageState createState() => _RDVPageState();
}

class _RDVPageState extends State<RDVPage> {
  int _selectedIndex = 3; // Index de l'onglet RDV

  final List<String> matieres = [
    'Mathématiques',
    'Physique',
    'Chimie',
    'Biologie',
    'Histoire',
    'Géographie',
    'Français',
    'Anglais',
  ];

  String? selectedMatiere;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String? get formattedDate {
    if (selectedDate == null) return null;
    return "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
  }

  String? get formattedTime {
    if (selectedTime == null) return null;
    return "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}";
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Naviguez vers les différentes pages ici selon l'index
    switch (index) {
      case 0:
        // Naviguer vers la page des Posts
        break;
      case 1:
        // Naviguer vers la page des Vidéos
        break;
      case 2:
        // Naviguer vers la page des Messages
        break;
      case 3:
        // Déjà sur la page RDVPage, rien à faire ici
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre un rendez-vous'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choisir une matière',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedMatiere,
              hint: const Text('Sélectionnez une matière'),
              isExpanded: true,
              items: matieres.map((String matiere) {
                return DropdownMenuItem<String>(
                  value: matiere,
                  child: Text(matiere),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMatiere = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Choisir une date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: formattedDate ?? 'Sélectionnez une date',
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choisir une heure',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: formattedTime ?? 'Sélectionnez une heure',
              ),
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: selectedMatiere != null && selectedDate != null && selectedTime != null
                    ? () {
                        // Action à réaliser lors de la confirmation du rendez-vous
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Rendez-vous confirmé'),
                            content: Text(
                                'Vous avez choisi ${selectedMatiere!} le ${formattedDate!} à ${formattedTime!}.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                child: const Text('Confirmer le rendez-vous'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              label: 'Posts',
              icon: Icon(
                Icons.post_add_rounded,
                size: 30,
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
              label: "Messages",
              icon: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.mail_rounded,
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
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
