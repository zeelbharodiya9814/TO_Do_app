import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_pr/res/To_do_list.dart';
import 'package:to_do_app_pr/views/screens/homepage.dart';
import 'package:to_do_app_pr/views/screens/loginpage.dart';
import 'package:to_do_app_pr/views/screens/signin_page.dart';
import 'package:to_do_app_pr/views/screens/signup_page.dart';
import 'package:to_do_app_pr/views/screens/splash_screen.dart';
import 'package:to_do_app_pr/views/screens/todos_add_page.dart';
import 'package:to_do_app_pr/views/screens/todos_update_page.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'Splash_screen',
      routes: {
        '/' : (context) => Home_page(),
        'Login_page' : (context) => Login_page(),
        'Splash_screen' : (context) => Splash_screen(),
        'Signup_page' : (context) => Signup_page(),
        'Signin_page' : (context) => Signin_page(),
        'Add_note' : (context) => Add_note(),
        'Update_note' : (context) => Update_note(),
        'TO_DO' : (context) => TO_DO(),
      },
    ),
  );
}