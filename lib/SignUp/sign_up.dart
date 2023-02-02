import 'package:flutter/material.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _SignUpFormKey = GlobalKey<FormState>();
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:BoxDecoration(
        color: Colors.black54,
          image: DecorationImage(image: AssetImage('assets/images/background.jpg',),fit: BoxFit.fill)
        ),
        child: ListView(
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*0.1),
            Form(key: _SignUpFormKey,child: Column(
              children:[
              GestureDetector(
                onTap: (){},
                child: Container(
                  height:MediaQuery.of(context).size.height*0.1,
                  width:MediaQuery.of(context).size.width*0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(255, 255, 255, 1)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imageFile ==null 
                    ? Icon(Icons.camera_enhance_rounded,color: Colors.grey,):Image.file(imageFile!,fit: BoxFit.fill,),
                  ),
                ),
              ),
              ],
            )),
          ],
        ),
      )
    );
  }
}