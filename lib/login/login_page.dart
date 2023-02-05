import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../ForgotPassword/forgot_passwd_screen.dart';
import '../services/global_method.dart';
import '../services/global_variables.dart';
import 'package:jobs_/SignUp/sign_up.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  FocusNode _passFocus = FocusNode();
  final TextEditingController _textEditingController1 =
      TextEditingController(text: '');
  final TextEditingController _textEditingController2 =
      TextEditingController(text: '');
  bool _obscureText = true;
  bool _isLoading = false;
  final _loginKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  void _submitFormOnLogin() async {
    final isLogin = _loginKey.currentState!.validate();
    if(isLogin){
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _textEditingController1.text.trim().toLowerCase(), 
          password: _textEditingController2.text.trim());
          Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
      catch(error){
        _isLoading = false;
        GlobalMethod.showErrorDialog(error:error.toString(), ctx:context);
      }
      setState(() {
        _isLoading = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: loginImageURL,
            placeholder: (context, url) => Image.asset(
              'assets/images/wallpaper.jpg',
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width * 0.7,
                  // width: 150,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login.png')),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Form(
                      key: _loginKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_passFocus),
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'email',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _textEditingController1,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return "correct email";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_passFocus),
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'password',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                // focusColor: Colors.deepPurple,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            controller: _textEditingController2,
                            validator: (value){
                              if (value!.isEmpty ){
                                return "valid password";
                              }
                              else{
                                return null;
                              }
                            }
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Text(
                                    'forgot passoword! ?',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white),
                                  ))),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          MaterialButton(
                            onPressed: _submitFormOnLogin,
                            child: Text('Login',),
                            color: Colors.amberAccent,
                            visualDensity: VisualDensity.standard,
                            elevation: 8,
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width*0.8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't you have an account",style: TextStyle(color: Colors.white),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUp())));
                              }, child: Text('Sign Up',style: TextStyle(color: Colors.blue),)),
                            ],
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
