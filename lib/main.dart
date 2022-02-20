// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/Models/UserModel.dart';
import 'package:practice/Screens/Home/Wrapper.dart';

import 'package:practice/Services/authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: _authentication.currentUser,
      initialData: null,
      lazy: true,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
