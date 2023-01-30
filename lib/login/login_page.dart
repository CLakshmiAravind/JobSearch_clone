import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/global_variables.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{

  late Animation<double> _animation;
  late AnimationController _animationController;
  FocusNode _passFocus = FocusNode();
  final TextEditingController _textEditingController = TextEditingController(text: '');
  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
  _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)
    ..addListener(() { 
      setState(() { });
    })
    ..addStatusListener((animationStatus) { 
      if(animationStatus == AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: loginImageURL,
            placeholder:(context,url)=>Image.asset('assets/images/wallpaper.jpg',
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
                    width :MediaQuery.of(context).size.width*0.8,
                    // width: 150,
                    height : MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(image:AssetImage('assets/images/login.png')),
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
                            onEditingComplete: ()=>FocusScope.of(context).requestFocus(_passFocus),style: TextStyle(color: Colors.amberAccent,fontWeight: FontWeight.bold,),
                            decoration: InputDecoration(
                              hintText: 'email',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _textEditingController,
                            validator: (value){
                              if(value!.isEmpty || !value.contains('@')){
                                return "correct email";
                              }
                              else{
                                return null; 
                              }
                            },
                          
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