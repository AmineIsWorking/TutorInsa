import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createRdv.dart';
import 'package:tutorinsa/pages/Common/navigation_bar.dart';

class RDVPage extends StatefulWidget {
  const RDVPage({super.key});

  @override
  _RDVPageState createState() => _RDVPageState();
}

class _RDVPageState extends State<RDVPage> {
  List<Map<String, dynamic>> _upcomingRDVs = [];
  List<Map<String, dynamic>> _pastRDVs = [];
  Map<String, List<Map<String, dynamic>>> _usersBySubjects = {};
  int _selectedIndex = 3; // Set the default selected index to RDV

  @override
  void initState() {
    super.initState();
    _fetchRendezVous();
    _fetchConnectedUsers();
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

  Future<void> _fetchConnectedUsers() async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot = await usersRef.where('isConnected', isEqualTo: true).get();

    final usersBySubjects = <String, List<Map<String, dynamic>>>{};

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Add document ID to the data
      List<String> subjects = List<String>.from(data['subjects'] ?? []);

      for (String subject in subjects) {
        if (!usersBySubjects.containsKey(subject)) {
          usersBySubjects[subject] = [];
        }
        usersBySubjects[subject]!.add(data);
      }
    }

    setState(() {
      _usersBySubjects = usersBySubjects;
    });
  }

  Widget _buildRendezVousList(List<Map<String, dynamic>> rdvs) {
    if (rdvs.isEmpty) {
      return const Center(
        child: Text("Vous n'avez pas de rendez-vous"),
      );
    }
  
    return ListView.builder(
      itemCount: rdvs.length,
      itemBuilder: (context, index) {
        final rdv = rdvs[index];
        final rdvDate = DateTime.parse(rdv['Date']);
        final rdvTime = rdv['Time'];
        final initiator = rdv['initiatedByUser'] != null
            ? '${rdv['initiatedByUser']['Nom']} ${rdv['initiatedByUser']['Prénom']}'
            : 'Unknown';
  
        return ListTile(
          title: Text(rdv['Matiere'] ?? 'No Description'),
          subtitle: Text('Date: ${rdvDate.toLocal()} \nHeure: $rdvTime \nInitiated by: $initiator'),
        );
      },
    );
  }

  Widget _buildConnectedUsersList() {
    if (_usersBySubjects.isEmpty) {
      return const Center(
        child: Text("Aucun utilisateur connecté"),
      );
    }

    return ListView(
      children: _usersBySubjects.entries.map((entry) {
        String subject = entry.key;
        List<Map<String, dynamic>> users = entry.value;
        
        return ExpansionTile(
          title: Text(subject),
          children: users.map((user) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['profileImageUrl'] ?? 'https://via.placeholder.com/150'),
              ),
              title: Text('${user['Nom']} ${user['Prénom']}'),
              subtitle: Text(user['email']),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Rendez-vous'),
        backgroundColor: const Color(0xFF5F67EA),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 70, // Set the height to your preference
              color: const Color(0xFF5F67EA),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Utilisateurs Connectés',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildConnectedUsersList(),
            ),
          ],
        ),
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
      bottomNavigationBar: NavigationBar2(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
