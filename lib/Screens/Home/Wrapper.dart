import 'package:flutter/material.dart';
import 'package:practice/Models/UserModel.dart';
import 'package:practice/Screens/Home/Home.dart';
import 'package:practice/Screens/auth/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  UserModel? user = null;
  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserModel?>(context, listen: true);
    });

    if (user == null || (user != null && user!.emailVerified == false)) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
