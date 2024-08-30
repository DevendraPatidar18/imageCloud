import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Forgotpassword extends StatefulWidget {
  Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController _emailController = TextEditingController();
  void dispose(){
    super.dispose();
    _emailController.dispose();
  }
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
    ElevatedButton(
        onPressed: (){
          String _email = _emailController.text;
          forgot(_emailController.text);
        },
    child: Container(
    alignment: Alignment.center,
    width: 250,
    child: Text('Login',style: TextStyle(color: Colors.blue),)))
          ]
          ),
        ),
      ),
    );
  }
  void forgot(email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) => {
      print('forgot password executed successfully')
    });

  }
}
