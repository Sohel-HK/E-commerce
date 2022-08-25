import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class productdetails extends StatefulWidget {
 var producets;
 productdetails(this.producets, {Key? key}) : super(key: key);

 @override
  _productdetailsState createState() => _productdetailsState(producets);
}

class _productdetailsState extends State<productdetails> {_productdetailsState(producets);

  Future Cardadd()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Cards-items");
    return _collectionRef.doc(currentuser!.email).collection("items").doc().set({
      "name":widget.producets["product_name"],
      "Price":widget.producets["Product_price"],
      "images":widget.producets["product_img"],
    }).then((value) => (Fluttertoast.showToast(msg: "yes done it")));
  }
  Future Favourateadd()async{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentuser = _auth.currentUser;
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Favourate_items");
  return _collectionRef.doc(currentuser!.email).collection("items").doc().set({
    "name":widget.producets["product_name"],
    "Price":widget.producets["Product_price"],
    "images":widget.producets["product_img"],
  }).then((value) => (Fluttertoast.showToast(msg: "yes add to Favourate")));
}

  var imageLink;
  @override
  void initState() {
    super.initState();
    imageLink = widget.producets['product_img'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 3,
        leading: Padding(padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: Colors.orange,
          child: IconButton(onPressed: ()=>Navigator.pop(context),icon: const Icon(Icons.arrow_back),),
          ),
        ),
        actions: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Favourate_items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name",isEqualTo: widget.producets['product_name']).snapshots(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.data==null){
                  return Center(child: CircularProgressIndicator(),);
                }
                return CircleAvatar(
                  child: IconButton(onPressed: ()=> snapshot.data.docs.length==0? Favourateadd():print("already added"),//Fluttertoast.showToast(msg: "Already added"),
                    icon: snapshot.data.docs.length==0? Icon(Icons.favorite_outline,color: Colors.white,):Icon(Icons.favorite),),
                );
              },

            ),
          ),
        ],
      ),
         body:SafeArea(child: Column(
                children: [
                  AspectRatio(aspectRatio: 1.5,
                    child: ListView(children: [Image.network(imageLink)],
                    ),
                  ),
                  Text(widget.producets["product_name"]),
                  Text(widget.producets["product-price"]),
                  Text(widget.producets["prouct-driscription"]),
                  SizedBox(
                   height: 20.h,
                    width: 100.h,
                    child: ElevatedButton(onPressed: ()=>Cardadd(),
                      child: Text("Click Me",style: (TextStyle(color: Colors.deepPurple,fontSize: 15.h)),),
                    ),
                  ),
                ],
         ),
         ) ,
    );
  }
}
