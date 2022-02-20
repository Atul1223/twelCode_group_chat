// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practice/Services/authentication.dart';
import 'package:flutter_svg/svg.dart';
import 'package:string_validator/string_validator.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  const RegisterPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = "", _email = "", _password = "", _confirmpassword = "";
  final Authentication _authentication = Authentication();
  Color confirmPaswordColor = Colors.redAccent;
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
                  'Sign-In',
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
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/register.svg',
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
                      hintText: 'Name',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 24),
                      icon: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.greenAccent,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
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
                        Icons.password_rounded,
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    cursorColor: Colors.greenAccent,
                    decoration: InputDecoration(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Confirm Password',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 24),
                      icon: Icon(
                        Icons.password,
                        size: 40,
                        color: confirmPaswordColor,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmpassword = value;
                        if (_confirmpassword == _password) {
                          setState(() {
                            confirmPaswordColor = Colors.greenAccent;
                          });
                        } else {
                          setState(() {
                            confirmPaswordColor = Colors.redAccent;
                          });
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (checkName(_name) == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Invalid name - check for spaces at start/numbers/special charcters/length',
                            style: TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.grey[700],
                          duration: Duration(seconds: 3),
                        ));
                      } else if (checkEmail(_email) == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Invalid email',
                            style: TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.grey[700],
                        ));
                      } else if (checkPassword(_password, _confirmpassword) ==
                          false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Invalid password',
                            style: TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.grey[700],
                        ));
                      } else if (checkPassLength(_password) == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'password should be at least of 6 characters',
                            style: TextStyle(fontSize: 14),
                          ),
                          backgroundColor: Colors.grey[700],
                        ));
                      } else {
                        dynamic result = await _authentication.register(
                            _email, _password, _name);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Email already exist',
                              style: TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.grey[700],
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Verification Email sent',
                              style: TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.grey[700],
                            duration: Duration(seconds: 2),
                          ));
                          widget.toggleView();
                        }
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool checkPassword(String pass, String cPass) {
  if (pass == cPass && pass.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool checkPassLength(String pass) {
  if (pass.length < 6) {
    return false;
  }
  return true;
}

bool checkName(String name) {
  if (name.isNotEmpty &&
      name[0] != ' ' &&
      name.length < 20 &&
      isAlpha(name.replaceAll(' ', ''))) {
    return true;
  }
  return false;
}

bool checkEmail(String email) {
  if (isEmail(email)) {
    return true;
  }
  return false;
}
