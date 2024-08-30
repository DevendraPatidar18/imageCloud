import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagecloud/Screens/forgot_password_screen.dart';
import 'package:imagecloud/Screens/signup_screen.dart';

import '../firebase_auth/firebase_auth_service.dart';
import 'home_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  final Firebaseauthseervice _auth = Firebaseauthseervice();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('LogIn',style: TextStyle(fontSize: 28,color: Colors.blue),),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Email',
                  border : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),

                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
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
                  border : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
                style: TextStyle(fontSize: 20),
              cursorColor: Colors.black,
                keyboardType: TextInputType.text,
            ),
              SizedBox(height: 100),


              ElevatedButton(onPressed: _signIn,
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                      child: Text('Login',style: TextStyle(color: Colors.blue),))),
              SizedBox(height: 8),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword(),));
                  },
                  child: Text('Forgot Password',style: TextStyle(color: Colors.blue),)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have any account?. "),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_Screen(),));
                    },
                    child: Text('SignUp',style: TextStyle(color: Colors.blue),),
                  )
                ],
              )
          ]
          ),
        ),
      ),
    );
  }
  void _signIn() async {

    String _email = _emailController.text;
    String _password = _passwordController.text;
    User? user = await _auth.signIn(_email, _password);
    if(user != null){
      print('User is created Successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
    }
    else{
      print('SignUp Faild');
    }

  }
}
