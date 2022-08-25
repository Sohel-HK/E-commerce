import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Card2 extends StatefulWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  State<Card2> createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cards-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
         // DocumentSnapshot _documentSnapshot = snapshot.data!.docs[0];
         // print(_documentSnapshot.data());
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(BuildContext context, int index){
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return  Card(
                  elevation: 5,
                  child: ListTile(
                    leading:Text(_documentSnapshot["name"]),
                   //   title: Text(_documentSnapshot['images']),
                    title: Text("\$ ${_documentSnapshot['Price']}" ,style: const TextStyle(color: Colors.orange),),
                    trailing: InkWell(
                      child: const CircleAvatar(
                        child: Icon(Icons.remove_circle),
                      ),
                      onTap: (){
                        FirebaseFirestore.instance.collection("Cards-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentSnapshot.id).delete();
                      },
                    ),
                  ),
                );

              }
          );
        },
      ),
    );
  }}
