import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Controller
  TextEditingController edtName = new TextEditingController();
  TextEditingController edtMobileNo = new TextEditingController();
  TextEditingController edtEmail = new TextEditingController();
  TextEditingController edtCmpName = new TextEditingController();
  TextEditingController edtRefferBy = new TextEditingController();

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
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  signUpDone(String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/Login');
              },
            ),
          ],
        );
      },
    );
  }

  singnUp() async {
    if (edtName.text != null &&
        edtMobileNo.text != null &&
        edtMobileNo.text.length == 10 &&
        edtEmail.text != null &&
        edtCmpName.text != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          var data = {
            'Name': edtName.text.trim(),
            'MobileNo': edtMobileNo.text.trim(),
            'Email': edtEmail.text.trim(),
            'CompanyName': edtCmpName.text.trim(),
            'RefferBy': edtRefferBy.text.trim(),
          };

          Services.guestSignUp(data).then((data) async {
            setState(() {
              isLoading = false;
            });

            if (data.Data == "1") {
              signUpDone("Registration Done Successfully");
            } else {
              setState(() {
                isLoading = false;
              });
              showMsg(data.Message);
            }
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            showMsg("Try Again.");
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
    }else{
      showMsg("Please Fill All Data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset("images/logo.jpg",
                          width: 180.0, height: 180.0, fit: BoxFit.contain),
                    ),
                    Container(
                      child: TextFormField(
                        controller: edtName,
                        scrollPadding: EdgeInsets.all(0),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: cnst.appPrimaryMaterialColor,
                            ),
                            hintText: "Name"),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: edtMobileNo,
                        scrollPadding: EdgeInsets.all(0),
                        decoration: InputDecoration(
                            counterText: "",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
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
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: edtEmail,
                        scrollPadding: EdgeInsets.all(0),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: cnst.appPrimaryMaterialColor,
                            ),
                            hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: edtCmpName,
                        scrollPadding: EdgeInsets.all(0),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Icon(
                              Icons.business,
                              color: cnst.appPrimaryMaterialColor,
                            ),
                            hintText: "Company Name"),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: edtRefferBy,
                        scrollPadding: EdgeInsets.all(0),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Icon(
                              Icons.supervisor_account,
                              color: cnst.appPrimaryMaterialColor,
                            ),
                            hintText: "Reffer By"),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 30),
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: cnst.appPrimaryMaterialColor,
                        minWidth: MediaQuery.of(context).size.width - 20,
                        onPressed: () {
                          if (isLoading == false) {
                            singnUp();
                          }
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/Login');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already Register ?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                            ),
                            Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: cnst.appPrimaryMaterialColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isLoading ? LoadinComponent() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
