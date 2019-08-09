import 'dart:io';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class GuestProfile extends StatefulWidget {
  @override
  _GuestProfileState createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  //loading var
  bool isLoading = false;
  List list;
  bool isEditable = false;
  bool isPersonalLoading = false;

  TextEditingController edtName = new TextEditingController();
  TextEditingController edtEmail = new TextEditingController();
  TextEditingController edtCmpName = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemberDetailsFromServer();
  }


  showHHMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
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

  getMemberDetailsFromServer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MemberId = prefs.getString(Session.MemberId);
      //String type = prefs.getString(Session.memType);

      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetMemberProfile(MemberId);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              list = data;
              setData(list);
            });
          } else {
            setState(() {
              isLoading = false;
            });
            //showMsg("Try Again.");
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
  }


  setData(List list) async {
    setState(() {
      //personal Info
      edtName.text = list[0]["Name"];
      edtEmail.text = list[0]["Email"];
      //Business Info
      edtCmpName.text = list[0]["CompanyName"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: isLoading
            ? LoadinComponent()
            : SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        //Make Design
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  AvatarGlow(
                                    startDelay: Duration(milliseconds: 1000),
                                    glowColor: cnst.appPrimaryMaterialColor,
                                    endRadius: 80.0,
                                    duration: Duration(milliseconds: 2000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration:
                                        Duration(milliseconds: 100),
                                    child: Material(
                                      elevation: 8.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        child: ClipOval(
                                          child: Image.network(
                                            'https://upload.wikimedia.org/wikipedia/commons/9/9c/Hrithik_at_Rado_launch.jpg',
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        radius: 50.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 100, top: 100),
                                      child: Image.asset(
                                        'images/plus.png',
                                        width: 25,
                                        height: 25,
                                      ))
                                ],
                              ),
                              Card(
                                margin: EdgeInsets.all(10),
                                elevation: 3,
                                child: Container(
                                  //padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20, bottom: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.account_circle,
                                                    color: cnst
                                                        .appPrimaryMaterialColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      'Personal Info',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isEditable) {
                                                      isEditable = !isEditable;
                                                      //sendPersonalInfo();
                                                    } else {
                                                      isEditable = true;
                                                    }
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: cnst
                                                          .appPrimaryMaterialColor,
                                                    ),
                                                    Text(
                                                      isEditable
                                                          ? "Update"
                                                          : 'Edit',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        TextFormField(
                                          controller: edtName,
                                          scrollPadding: EdgeInsets.all(0),
                                          decoration: InputDecoration(
                                              labelText: "Name:",
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              hintText: "Name"),
                                          enabled: isEditable,
                                          minLines: 1,
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        TextFormField(
                                          controller: edtEmail,
                                          scrollPadding: EdgeInsets.all(0),
                                          decoration: InputDecoration(
                                              labelText: "Email",
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              hintText: "Email"),
                                          enabled: isEditable,
                                          minLines: 1,
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        TextFormField(
                                          controller: edtCmpName,
                                          scrollPadding: EdgeInsets.all(0),
                                          decoration: InputDecoration(
                                              labelText: "Company Name",
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              hintText: "Company Name"),
                                          enabled: isEditable,
                                          minLines: 1,
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:
                          isPersonalLoading ? LoadinComponent() : Container(),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}