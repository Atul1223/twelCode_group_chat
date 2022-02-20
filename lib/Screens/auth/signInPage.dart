// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice/main.dart';
import 'package:practice/Services/authentication.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  const SignInPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Authentication _authentication = Authentication();
  String _email = "", _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/login.svg',
                    height: 250,
                    width: 250,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    cursorColor: Colors.greenAccent,
                    decoration: InputDecoration(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 24),
                      icon: Icon(
                        Icons.alternate_email,
                        size: 40,
                        color: Colors.greenAccent,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    cursorColor: Colors.greenAccent,
                    decoration: InputDecoration(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 24),
                      icon: Icon(
                        Icons.password,
                        size: 40,
                        color: Colors.greenAccent,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      dynamic result =
                          await _authentication.signIn(_email, _password);
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Problem occured! email not verified/ password incorrect/ email incorrect',
                            style: TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.grey[700],
                          duration: Duration(seconds: 3),
                        ));
                      }
                      main();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () async {},
                      child: Text(
                        'Forgot Password?',
                        style:
                            TextStyle(fontSize: 16, color: Colors.greenAccent),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
