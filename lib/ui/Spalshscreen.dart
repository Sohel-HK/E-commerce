import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled49/ui/login_screen.dart';
import 'Botton_pages.dart';

class spalshscreen extends StatefulWidget {
  const spalshscreen({Key? key}) : super(key: key);

  @override
  _spalshscreenState createState() => _spalshscreenState();
}

class _spalshscreenState extends State<spalshscreen> {
  FirebaseAuth user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if(user.currentUser!=null){
     Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const BottomNavController())));
    }else{
      Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: appcolors.sohel,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("E-Commerce",style: TextStyle(color: Colors.white70,fontSize: 30.sp),),
              SizedBox(height: 15.h,),
              const CircularProgressIndicator(color: Colors.white70,),
            ],
          ),
        ),
      ),
    );
  }
}
