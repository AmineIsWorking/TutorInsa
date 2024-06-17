import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createRdv.dart'; // Importez votre fichier create_rdv.dart

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({super.key});

  @override
  _RendezVousPageState createState() => _RendezVousPageState();
}

class _RendezVousPageState extends State<RendezVousPage> {
  List<Map<String, dynamic>> _upcomingRDVs = [];
  List<Map<String, dynamic>> _pastRDVs = [];

  @override
  void initState() {
    super.initState();
    _fetchRendezVous();
  }

  Future<void> _fetchRendezVous() async {
    // Récupérez l'identifiant de l'utilisateur à partir de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      // Gérez l'erreur si l'utilisateur n'est pas connecté ou si l'ID utilisateur est manquant
      return;
    }

    CollectionReference rendezVousRef = FirebaseFirestore.instance.collection('Rendezvous');
    QuerySnapshot querySnapshot = await rendezVousRef.where('InitiatedBy', isEqualTo: userId).get();

    final now = DateTime.now();
    final upcomingRDVs = <Map<String, dynamic>>[];
    final pastRDVs = <Map<String, dynamic>>[];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime rdvDate = DateTime.parse(data['Date']);
      TimeOfDay rdvTime = TimeOfDay(
        hour: int.parse(data['Time'].split(':')[0]),
        minute: int.parse(data['Time'].split(':')[1]),
      );
      data['id'] = doc.id;  // Add document ID to the data

      // Fetch user who initiated the RDV
      if (data['InitiatedBy'] != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(data['InitiatedBy']).get();
        data['initiatedByUser'] = userSnapshot.data();
      }

      if (rdvDate.isAfter(now)) {
        upcomingRDVs.add(data);
      } else {
        pastRDVs.add(data);
      }
    }

    setState(() {
      _upcomingRDVs = upcomingRDVs;
      _pastRDVs = pastRDVs;
    });
  }

  Widget _buildRendezVousList(List<Map<String, dynamic>> rdvs) {
    return ListView.builder(
      itemCount: rdvs.length,
      itemBuilder: (context, index) {
        final rdv = rdvs[index];
        final rdvDate = DateTime.parse(rdv['Date']);
        final rdvTime = rdv['Time'];
        final initiator = rdv['initiatedByUser'] != null
            ? '${rdv['initiatedByUser']['Nom']} ${rdv['initiatedByUser']['Prenom']}'
            : 'Unknown';

        return ListTile(
          title: Text(rdv['Matiere'] ?? 'No Description'),
          subtitle: Text('Date: ${rdvDate.toLocal()} \nHeure: $rdvTime \nInitiated by: $initiator'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes RDV'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'À venir'),
                Tab(text: 'Passés'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildRendezVousList(_upcomingRDVs),
                  _buildRendezVousList(_pastRDVs),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const createRdv()),
          ).then((value) {
            _fetchRendezVous(); // Rafraîchit la liste des rendez-vous après la création d'un nouveau RDV
          });
        },
        backgroundColor: const Color(0xFF5F67EA),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
