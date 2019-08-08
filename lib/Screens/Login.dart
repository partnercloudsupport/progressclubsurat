import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController edtMobile = new TextEditingController();

  //loading var
  bool isLoading = false;

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkLogin() async {
    if (edtMobile.text != "" && edtMobile.text != null) {
      if (edtMobile.text.length == 10) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            setState(() {
              isLoading = true;
            });
            Future res = Services.MemberLogin(edtMobile.text);
            res.then((data) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (data != null && data.length > 0) {
                setState(() {
                  isLoading = false;
                });
                await prefs.setString(
                    Session.MemberId, data[0]["Id"].toString());
                await prefs.setString(
                    Session.Mobile, data[0]["MobileNo"].toString());
                await prefs.setString(Session.Name, data[0]["Name"].toString());
                await prefs.setString(
                    Session.CompanyName, data[0]["CompanyName"].toString());
                await prefs.setString(
                    Session.Email, data[0]["Email"].toString());
                await prefs.setString(
                    Session.Photo, data[0]["Photo"].toString());
                await prefs.setString(Session.Type, data[0]["Type"].toString());
                await prefs.setString(Session.VerificationStatus,
                    data[0]["VerificationStatus"].toString());
                await prefs.setString(
                    Session.ChapterId, data[0]["ChapterId"].toString());

                if (data[0]["VerificationStatus"].toString() == "1") {
                  Navigator.pushReplacementNamed(context, '/Dashboard');
                } else {
                  Navigator.pushReplacementNamed(context, '/OtpVerification');
                }
              } else {
                showMsg("Invalid login Detail.");
                setState(() {
                  isLoading = false;
                });
              }
            }, onError: (e) {
              print("Error : on Login Call $e");
              showMsg("$e");
              setState(() {
                isLoading = false;
              });
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showMsg("No Internet Connection.");
          }
        } on SocketException catch (_) {
          showMsg("No Internet Connection.");
        }
      } else {
        showMsg("Please Enter Valid Mobile No.");
      }
    } else {
      showMsg("Please Enter Mobile No.");
    }
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset("images/logo.jpg",
                            width: 200.0, height: 200.0, fit: BoxFit.contain),
                      ),
                      Container(
                        height: 75,
                        child: TextFormField(
                          controller: edtMobile,
                          scrollPadding: EdgeInsets.all(0),
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: cnst.appPrimaryMaterialColor,
                              ),
                              hintText: "Mobile No"),
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: cnst.appPrimaryMaterialColor,
                          minWidth: MediaQuery.of(context).size.width - 20,
                          onPressed: () {
                            //if (isLoading == false) this.SaveOffer();
                            //Navigator.pushReplacementNamed(context, '/Dashboard');
                            //Navigator.pushReplacementNamed(context, '/OtpVerification');
                            if (isLoading == false) {
                              checkLogin();
                            }
                          },
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/SignUp');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New Member ?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: cnst.appPrimaryMaterialColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/ForgotPassword');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: cnst.appPrimaryMaterialColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              isLoading ? LoadinComponent() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
