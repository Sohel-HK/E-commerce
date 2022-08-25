import 'package:flutter/material.dart';
import 'package:untitled49/ui/botton_pages/card2.dart';
import 'package:untitled49/ui/botton_pages/favourate.dart';
import 'package:untitled49/ui/botton_pages/home.dart';
import 'package:untitled49/ui/botton_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _cuttentindex = 1;
  final _pages = [Home(), const Profile(), const Favourate(), const Card2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        currentIndex: _cuttentindex,
        selectedLabelStyle:
            const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "SignOut"), // BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Card"),
        ],
        onTap: (index) {
          setState(() {
            _cuttentindex = index;
          });
        },
      ),
      body: _pages[_cuttentindex],
    );
  }
}
