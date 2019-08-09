import 'dart:async';
import 'package:flutter/material.dart';
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String MemberId = prefs.getString(cnst.Session.MemberId);
      if (MemberId != null && MemberId != "")
        Navigator.pushReplacementNamed(context, '/Dashboard');
      else {
        Navigator.pushReplacementNamed(context, '/Login');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/logo.jpg",
                  width: 200.0, height: 200.0, fit: BoxFit.contain),
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Text(
                  'Progress Club',
                  style: TextStyle(
                      color: cnst.secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700
                      //fontSize: 18.0,
                      ),
                ),
              )
            ],
          ),
        ));
  }
}
