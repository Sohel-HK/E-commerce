import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled49/ui/Botton_pages.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser?.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "age":_ageController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>const BottomNavController()))).catchError((error)=>
        print("something is wrong. $error")) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                  TextStyle(fontSize: 22.sp, color: Colors.deepOrange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFFBC8B8B),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  //readOnly: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                  ),
                ),
                //myTextField("enter your name",TextInputType.text,_nameController),
               // myTextField("enter your phone number",TextInputType.number,_phoneController),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                //  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your number",
                  ),
                ),
                Container(
                  color: Colors.cyan,
                  child: TextField(
                    controller: _dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "date of birth",
                      suffixIcon: IconButton(
                        onPressed: () => _selectDateFromPicker(context),
                        icon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  //  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your age",
                  ),
                ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",border: const OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              //  myTextField("enter your age",TextInputType.number,_ageController),

                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                 height: 50.h,
                  width: 2.sw,
                  child: ElevatedButton(
                   onPressed: (){
                     sendUserDataToDB();
                   },
                    child: const Text("Continue",style: TextStyle(color: Colors.white,fontSize: 20),),

                    style:ElevatedButton.styleFrom(primary: const Color(0xBFDFAEFC),) ,
                  ),
                ),
                // elevated button
                //customButton("Continue",()=>sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
