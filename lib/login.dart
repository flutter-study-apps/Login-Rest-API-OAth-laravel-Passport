import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
// import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import './widgets/loginform.dart';
import './widgets/socialicons.dart';
import './customicons.dart';
import './register_page.dart';
import './main.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isSelected = false;
  bool _isLoading = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  void _radio(){
    setState(() {
     _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected)=>Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width:  2.0, color: Colors.grey[500]),
    ),
    child: isSelected ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[700],

      ),
    )
    :Container(),
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  signIn(String email, pass) async {
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'email': email,
      'password': pass,
      	'c_password': pass,
    };
    var jsonResponse = null;
     var response = await http.post("http://subicjobs.digitappstudio.com/api/login", body: data);
    //  var response = await http.post("http://subicjobs.com/api/login", body: data);
    
     debugPrint(response.statusCode.toString() );
    if(response.statusCode ==200) {
          
      jsonResponse = json.decode(response.body);
  
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        // print(jsonResponse['success']['token']);
        sharedPreferences.setString("token", jsonResponse['success']['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
   
        
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      // print(response.body);
    }
  }




  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance=ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 770, height: 1334, allowFontScaling: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
   
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Container(
        child: _isLoading ? Center(child: CircularProgressIndicator()) :  Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image(image: AssetImage('images/subicjobs-login-header.jpg'),),
                )
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 30.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image(image: AssetImage(
                          'images/subicjobs-login-logo.jpg'),
                          width: ScreenUtil.getInstance().setWidth(110),
                          height: ScreenUtil.getInstance().setHeight(110),
                          ),
                        Text("SubicJobs",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize:  ScreenUtil.getInstance().setSp(46),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                          height: ScreenUtil.getInstance().setHeight(300),
                    ),
                    //form
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(450),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0,15.0),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0,-10.0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30, top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("LOGIN", style:TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontFamily: "Poppins-Bold",
                                letterSpacing: .6,
                              )),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(25),
                              ),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: ScreenUtil.getInstance().setHeight(35),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                Text("Forgot Password?", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: ScreenUtil.getInstance().setSp(28)
                                ),)
                              ],),
                          
                            ],
                          ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 12,),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(width: 8.0,),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                fontFamily: "Poppines-Medium", fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330.0),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea),
                                ]
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [BoxShadow(
                                color:(Color(0xFF6078ea).withOpacity(.3)),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: emailController.text == "" || passwordController.text == "" ? null : () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  signIn(emailController.text, passwordController.text);
                                },
                                child: Center(
                                  child: Text(
                                    "Signin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // horizontal
                        horizontalLine(),
                        Text("Social Login",
                          style:TextStyle(
                            fontFamily: "Poppins-medium",
                            fontSize: 16.0
                          ),
                        ),
                        horizontalLine(),
                      ],
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          [ Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8),],
                          CustomIcons.facebook,
                          (){},
                        ),
                        SocialIcon(
                          [ Color(0xFFff4f38),
                            Color(0xFFff355d),],
                          CustomIcons.google,
                          (){},
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New User?",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();})),
                          child: Text("Signup",
                          style: TextStyle(
                            color: Color(0xFF5d74e3),
                            fontFamily: "Poppins-Bold"
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}