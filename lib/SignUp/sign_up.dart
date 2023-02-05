// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io' ;

import 'package:image_picker/image_picker.dart';

import '../services/global_method.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _SignUpFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? imageUrl;
  File? imageFile;
  FocusNode _passFocus = FocusNode();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passoword = TextEditingController();
  TextEditingController conPasswd = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    name.dispose();
    email.dispose();
    passoword.dispose();
    conPasswd.dispose();
    location.dispose();
    phoneNo.dispose();
    _passFocus.dispose();
  }

  void _selectImage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text("select picture from"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _getFromCamera,
                child: Row(
                  children: [
                    Icon(Icons.camera,color: Colors.purple,),
                    Text('Camera',style: TextStyle(color: Colors.purple),)
                  ],
                ),                
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              InkWell(
                onTap: _getFromGallery,
                child: Row(
                  children: [
                    Icon(Icons.photo,color: Colors.purple,),
                    Text('Gallery',style: TextStyle(color: Colors.purple),)
                  ],
                ),
              )

            ],
          ),
      );
    });
  }

  void _getFromCamera() async{
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }


  void _getFromGallery () async{
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }



  void _cropImage (filepath) async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: filepath,maxHeight: 1080,maxWidth: 1080);
    if(croppedFile != null){
      setState(() {
         imageFile = File(croppedFile.path);
      });
    }
  }


  void _submitForm()async{
    final isValid = _SignUpFormKey.currentState!.validate();
    if(isValid){
      if(imageFile==null){
        GlobalMethod.showErrorDialog(error: "profile photo is needed", ctx: context);
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(email: email.text.trim().toLowerCase(), password: conPasswd.text.trim());
        final User? user = _auth.currentUser;
        final uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child('userImages').child(uid+'.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id':uid,
          'name':name.text,
          'email':email.text,
          'password':conPasswd.text,
          'image':imageUrl,
          'phone':phoneNo.text,               
          'location':location.text,
          'createdAt':Timestamp.now(),
        });
      Navigator.canPop(context)?Navigator.pop(context):null; 
      } catch (e) {
        setState(() {
          _isLoading = false;
          GlobalMethod.showErrorDialog(error: e.toString(), ctx: context);
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black54,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpg',
              ),
              fit: BoxFit.fill)),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Form(
              key: _SignUpFormKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap:_selectImage,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: imageFile == null
                            ? Icon(
                                Icons.camera_enhance_rounded,
                                color: Colors.grey,
                              )
                            : Image.file(
                                imageFile!,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ), // to display photo, if photo is not present then it shows camera icon
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocus),
                      controller: name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Name',
                          focusColor: Colors.amberAccent,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.red,
                          ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocus),
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "email@example.com",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocus),
                      keyboardType: TextInputType.phone,
                      controller: phoneNo,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "10-dight number",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocus),
                      controller: location,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          hintText: 'address',
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.amberAccent,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.red,
                          ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                      obscureText: _obscureText2,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocus),
                      controller: passoword,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: _obscureText2
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onTap: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                        ),
                        hintText: "password",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                        controller: conPasswd,
                        obscureText: _obscureText,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passFocus),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Conform password",
                          suffixIcon: GestureDetector(
                            child: _obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "conform password must same as password";
                          } else {
                            return null;
                          }
                        },
                      )),
                  
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              )),
        ],
      ),
    ));
  }
}
