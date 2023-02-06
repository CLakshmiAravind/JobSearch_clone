import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_/login/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  FocusNode _passFocusn = FocusNode();
  // TextEditingController email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _resetPasswd()async{
    try {
      await _auth.sendPasswordResetEmail(email: email.text.trim());
      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              controller: email,
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  fillColor: Colors.white54,
                  hintText: "email@example.com",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter valid email";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent,
              
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(onPressed: _resetPasswd, child: Text('send OTP',style: TextStyle(color:Colors.white),))
              )
        ],
      ),
    );
  }
}
