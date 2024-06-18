import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/Tutor/NavigationBar.dart';

class TutorRDVPage extends StatefulWidget {
  const TutorRDVPage({super.key});

  @override
  _TutorRDVPageState createState() => _TutorRDVPageState();
}

class _TutorRDVPageState extends State<TutorRDVPage> {
  int _selectedIndex = 3;

  List<Map<String, dynamic>> appointmentRequests = [
    {
      'firstName': 'Ludovick',
      'lastName': 'Lainé',
      'level': '3A',
      'subject': 'Mathématiques',
      'dateTime': DateTime(2024, 6, 20, 14, 30),
    },
    {
      'firstName': 'Emile',
      'lastName': 'Peltier',
      'level': '3A',
      'subject': 'Informatique',
      'dateTime': DateTime(2024, 6, 22, 10, 0),
    },
    // Ajouter d'autres demandes de rendez-vous ici si nécessaire
  ];

  List<Map<String, dynamic>> acceptedAppointments = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demandes de Rendez-vous'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF5F67EA),
        automaticallyImplyLeading: false, // Masquer le bouton de retour
      ),
      body: ListView.builder(
        itemCount: appointmentRequests.length,
        itemBuilder: (context, index) {
          final request = appointmentRequests[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('${request['firstName']} ${request['lastName']}'),
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Niveau: ${request['level']}'),
                    Text('Matière: ${request['subject']}'),
                    Text(
                      'Date: ${request['dateTime'].day}/${request['dateTime'].month}/${request['dateTime'].year}',
                    ),
                    Text(
                      'Heure: ${request['dateTime'].hour}:${request['dateTime'].minute}',
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green, size: 30),
                      onPressed: () {
                        _acceptAppointment(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red, size: 30),
                      onPressed: () {
                        _showRefuseConfirmationDialog(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToAcceptedAppointments(context);
        },
        icon: const Icon(Icons.event_available),
        label: const Text(
          'Voir les RDV acceptés',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5F67EA),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar2(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _showRefuseConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Refuser le rendez-vous'),
          content: const Text('Êtes-vous sûr de vouloir refuser ce rendez-vous ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
            ),
            TextButton(
              child: const Text('Je suis sûr'),
              onPressed: () {
                setState(() {
                  appointmentRequests.removeAt(index);
                });
                Navigator.of(context).pop(); // Ferme la boîte de dialogue après suppression
              },
            ),
          ],
        );
      },
    );
  }

  void _acceptAppointment(int index) {
    setState(() {
      acceptedAppointments.add(appointmentRequests[index]);
      appointmentRequests.removeAt(index);
    });
  }

  void _navigateToAcceptedAppointments(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AcceptedAppointmentsPage(acceptedAppointments),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset.zero;
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}

class AcceptedAppointmentsPage extends StatelessWidget {
  final List<Map<String, dynamic>> acceptedAppointments;

  const AcceptedAppointmentsPage(this.acceptedAppointments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rendez-vous acceptés'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF5F67EA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Retour à la page précédente
          },
        ),
      ),
      body: ListView.builder(
        itemCount: acceptedAppointments.length,
        itemBuilder: (context, index) {
          final appointment = acceptedAppointments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('${appointment['firstName']} ${appointment['lastName']}'),
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Niveau: ${appointment['level']}'),
                    Text('Matière: ${appointment['subject']}'),
                    Text(
                      'Date: ${appointment['dateTime'].day}/${appointment['dateTime'].month}/${appointment['dateTime'].year}',
                    ),
                    Text(
                      'Heure: ${appointment['dateTime'].hour}:${appointment['dateTime'].minute}',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
