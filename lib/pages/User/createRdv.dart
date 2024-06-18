import 'package:flutter/material.dart';

class createRdv extends StatefulWidget {
  const createRdv({super.key});

  @override
  _RDVPageState createState() => _RDVPageState();
}

class _RDVPageState extends State<createRdv> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre rendez-vous'),
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
    );
  }
}


