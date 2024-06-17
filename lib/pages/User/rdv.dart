import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    CollectionReference rendezVousRef = FirebaseFirestore.instance.collection('RendezVous');
    QuerySnapshot querySnapshot = await rendezVousRef.get();

    final now = DateTime.now();
    final upcomingRDVs = <Map<String, dynamic>>[];
    final pastRDVs = <Map<String, dynamic>>[];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime rdvDate = (data['date'] as Timestamp).toDate();
      data['id'] = doc.id;  // Add document ID to the data

      // Fetch user who initiated the RDV
      if (data['initiatedBy'] != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(data['initiatedBy']).get();
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
        final rdvDate = (rdv['date'] as Timestamp).toDate();
        final rdvTime = rdv['heure'] ?? 'No time provided';
        final initiator = rdv['initiatedByUser'] != null
            ? '${rdv['initiatedByUser']['Nom']} ${rdv['initiatedByUser']['Prenom']}'
            : 'Unknown';

        return ListTile(
          title: Text(rdv['description'] ?? 'No Description'),
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
          );
        },
        backgroundColor: const Color(0xFF5F67EA),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


