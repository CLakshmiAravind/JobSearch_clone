import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_/services/global_method.dart';
import 'package:uuid/uuid.dart';

import '../widgets/bottom_nav_bar.dart';

class UploadJob extends StatefulWidget {
  @override
  State<UploadJob> createState() => _UploadJobState();
}

class _UploadJobState extends State<UploadJob> {
  UploadJob() {
    category = lists[0];
  }

  final lists = ['small', 'medium', 'large', 'v.large', 'x'];
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _category =
      TextEditingController(text: "select job category");
  final _formKey = GlobalKey<FormState>();
  String category = "";


  void _uploadPost()async{
    final jobId = Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    // final isValid = _formKey.currentState!.validate();
    try {
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
        'id':jobId,
        'uploadedBy':_uid,
        'title':_title.text,
        'description':_description.text,
        'date':_date.text,
        // 'category':category,
        'email':user.email,
        'comments':[],
        'recruitment':true,
        'createdAt':Timestamp.now(),
        'applicants':0
      });
      await Fluttertoast.showToast(
        msg:"the post is being uploaded"
      );
      _title.clear();
      _description.clear();
      _category.clear();
      _date.clear();
    } catch (e) {
      GlobalMethod.showErrorDialog(error:e.toString(),ctx:context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange.shade300, Colors.purple.shade300],
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 0.9])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
            child: Text("upload a job"),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Center(
                      child: Text(
                    "please fill all the fields.",
                    style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
                  Divider(),
                  // Text('Job Category:',
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  // DropdownButton<String>(
                  //   value: category,
                  //   icon: const Icon(
                  //     Icons.arrow_downward,
                  //     color: Colors.yellow,
                  //   ),
                  //   elevation: 16,
                  //   style: const TextStyle(color: Colors.black, fontSize: 20),
                  //   underline: Container(
                  //     height: 1,
                  //     color: Colors.deepPurpleAccent,
                  //   ),
                  //   onChanged: (String? value) {
                  //     // This is called when the user selects an item.
                  //     setState(() {
                  //       category = value!;
                  //     });
                  //   },
                  //   items: lists.map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text('Job Title:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          controller: _title,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'enter name of the job',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Job Description:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          controller: _description,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'enter description about the job',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          maxLength: 100,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Job Deadline Date: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _date,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "dd-mm-yyyy",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: _uploadPost,
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          indexNum: 2,
        ),
      ),
    );
  }
}
