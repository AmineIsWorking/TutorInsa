import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
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
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.post_add_rounded,
                    text: 'Posts',
                  ),
                  GButton(
                    icon: Icons.play_arrow_rounded,
                    text: 'Vidéos',
                  ),
                  GButton(
                    icon: Icons.mail_rounded,
                    text: 'Messages',
                  ),
                  GButton(
                    icon: Icons.auto_stories_rounded,
                    text: 'RDV',
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  if (index == selectedIndex) {
                    return;
                  }

                  Widget nextPage;
                  switch (index) {
                    case 0:
                      nextPage = const UserPage();
                      break;
                    case 1:
                      nextPage = const VideosPage();
                      break;
                    case 2:
                      nextPage = const ReceptPage();
                      break;
                    case 3:
                      nextPage = const RDVPage();
                      break;
                    default:
                      nextPage = const UserPage();
                  }

                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: nextPage,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                  onItemTapped(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
