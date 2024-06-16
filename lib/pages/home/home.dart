import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/User/posts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                _buildTitle(),
                const SizedBox(height: 30),
                _buildLogo(),
                const SizedBox(height: 280),
                _buildLoginForm(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Text(
        'Connexion',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/Logo2.png',
      width: 150,
      height: 150,
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'E-mail INSA',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Mot de passe',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const UserPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0, 1);
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
                  },
                  child: const Text('Se connecter'),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Ajoutez votre logique de navigation ici
                  },
                  child: const Text('S\'inscrire'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
