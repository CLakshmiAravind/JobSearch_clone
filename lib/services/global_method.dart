import 'package:flutter/material.dart';
import 'package:jobs_/login/login_page.dart';

class GlobalMethod{
  static void showErrorDialog({required String error, required BuildContext ctx}){
    showDialog(context: ctx, builder: (context){
      return AlertDialog(
        title: Row(children: [
          Padding(padding: EdgeInsets.all(10), child: Icon(Icons.logout,size: 35,),),
          Padding(padding: EdgeInsets.all(10),child: Text('Error Occured'),)
        ]),
        content: Text('$error'),
        actions: [
          TextButton(onPressed: (){
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          }, child: Text('OK',style: TextStyle(color: Colors.red),))
        ],
      );
    });
  }
}