import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade300, Colors.purple.shade300],
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.9],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade300, Colors.purple.shade300],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 0.9],
              ),
            ),
            child: Text("Job_Screen"),
          ),
        ),
        
        bottomNavigationBar: BottomNavBar(indexNum: 0),
      ),
    );
  }
}
