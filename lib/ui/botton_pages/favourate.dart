import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';

class Favourate extends StatefulWidget {
  const Favourate({Key? key}) : super(key: key);
  @override
  _FavourateState createState() => _FavourateState();
}

class _FavourateState extends State<Favourate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              },
              child: Text("Signout")),
        ),
      ),
    );
  }
}
