import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagecloud/Screens/home_screen.dart';
import 'package:imagecloud/firebase_auth/firebase_auth_service.dart';

class Signup_Screen extends StatefulWidget {
  Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final Firebaseauthseervice _auth = Firebaseauthseervice();

  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("SignUp",
                    style: TextStyle(fontSize: 28, color: Colors.blue)),
                SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'UserName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black))),
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black))),
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black))),
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 120),
                ElevatedButton(onPressed: _signUp,
                    child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        child: Text('SignUp',style: TextStyle(color: Colors.blue),))),
              ]),
        ),
      ),
    );
  }

  void _signUp() async {
    String _userName = _usernameController.text;
    String _email = _emailController.text;
    String _password = _passwordController.text;
    User? user = await _auth.signUp(_email, _password);
    if (user != null) {
      print('User is created Successfully');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      print('SignUp Faild');
    }
  }
}
