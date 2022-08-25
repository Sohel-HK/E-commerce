import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ui/Spalshscreen.dart';


// app main fuction
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () {
        return  MaterialApp(
          title: "Digital Marketing",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blueGrey),
            home:spalshscreen() ,
          );
      }
    );
  }
}

