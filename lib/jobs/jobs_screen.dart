import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job screen"),
      ),
      body: MaterialButton(onPressed: _auth.signOut,child: Icon(Icons.logout_outlined,color: Colors.white,), ),
    );
  }
}