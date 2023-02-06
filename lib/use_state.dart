import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_/login/login_page.dart';

import 'jobs/jobs_screen.dart';

class useState extends StatelessWidget {
  const useState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx,userSnapshot){
        if (userSnapshot.data == null) {
          return LoginPage();
        } else if (userSnapshot.hasData){
          return JobScreen();
        }
        else if(userSnapshot.hasError){
          print("an error has errored");
          return Scaffold(
            body: Container(
              child: Text('an error has been occured'),
            ),
          );
        }
        else if(userSnapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
      return Scaffold(
        body: Container(
          child: Text('something went wrong'),
        ),
      );
      },
    );
  }
}