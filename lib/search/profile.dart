import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_/use_state.dart';

import '../widgets/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Do you want to logout ?"),
            icon: Icon(Icons.logout),
            actions: [
              TextButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => useState()));
                  },
                  child: Text('yes')),
              TextButton(
                  onPressed: Navigator.of(context).pop, child: Text('No')),
            ],
          );
        });
  }

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile'),
                TextButton(
                    onPressed: () {
                      _logout();
                    },
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(indexNum: 3),
      ),
    );
  }
}
