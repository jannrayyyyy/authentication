import 'package:authentication/presentation/screens/tab_screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'tab_screens/account_screen.dart';
import 'tab_screens/people_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    const MessageScreen(),
    const PeopleScreen(),
    const AccountScreen(),
  ];
  List<String> titles = ['Chat', 'People', 'My Account'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
        ),
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: GNav(
        color: Colors.grey,
        activeColor: const Color(0xFF66CDAA),
        onTabChange: (selectedIndex) {
          setState(() {
            this.selectedIndex = selectedIndex;
          });
        },
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.message,
            text: 'message',
          ),
          GButton(
            icon: Icons.person,
            text: 'people',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'account',
          ),
        ],
      ),
    );
  }
}
