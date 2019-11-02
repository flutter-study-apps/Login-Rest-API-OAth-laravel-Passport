import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
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
                decoration: InputDecoration(
                  hintText: "username",
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
    );
  }
}