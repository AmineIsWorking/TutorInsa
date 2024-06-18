import 'package:flutter/material.dart';
import 'package:tutorinsa/pages/User/posts.dart';
import 'package:tutorinsa/pages/User/rdv.dart';
import 'package:tutorinsa/pages/User/recept.dart';
import 'package:tutorinsa/pages/User/videos.dart';

class NavigationBar2 extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavigationBar2({
    super.key,
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
          items: const [
            BottomNavigationBarItem(
              label: 'Posts',
              icon: Icon(
                Icons.post_add_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: "Vidéos",
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: "Messages",
              icon: Icon(
                Icons.mail_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: "RDV",
              icon: Icon(
                Icons.auto_stories_rounded,
                size: 30,
              ),
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == selectedIndex) {
              return;
            }
          
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserPage(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideosPage(),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReceptPage(),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RDVPage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}