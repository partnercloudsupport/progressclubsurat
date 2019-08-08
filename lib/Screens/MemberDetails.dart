import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberDetails extends StatefulWidget {
  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  String usernName = "", cmpName = "", mobileNo = "";
  TextEditingController edtWebsite = new TextEditingController();
  TextEditingController edtEmail = new TextEditingController();
  TextEditingController edtAddress = new TextEditingController();

  //loading var
  bool isLoading = true;
  List list = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemberDetailsFromServer();
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
      String MemberId = prefs.getString(Session.memId);
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
              isLoading = false;
              list = data;
              usernName = list[0]["Name"];
              cmpName = list[0]["CompanyName"];
              edtWebsite.text = "";
              edtEmail.text = list[0]["Email"];
              edtAddress.text = "";
              mobileNo = list[0]["MobileNo"];
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

  _launchURL(String mobileNo) async {
    var url = 'tel:${mobileNo}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: cnst.appPrimaryMaterialColor,
          ),
        ),
        actionsIconTheme: IconThemeData.fallback(),
        title: Text(
          'Member Details',
          style: TextStyle(
              color: cnst.appPrimaryMaterialColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: isLoading
            ? LoadinComponent()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //Make Design
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: <Widget>[
                          ClipOval(
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/9/9c/Hrithik_at_Rado_launch.jpg',
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              '${usernName}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: cnst.appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            '${cmpName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/Acceptances');
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                            15) /
                                        2,
                                    height: 80,
                                    child: GestureDetector(
                                      onTap: () {
                                        //mobileNo
                                        print(list[0]["MobileNo"]);
                                        launch("tel:${list[0]["MobileNo"]}");
                                        //_launchURL();
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          //Text(''), Text('Acceptances')
                                          Padding(
                                            padding: EdgeInsets.only(right: 30),
                                            child: Image.asset(
                                              'images/icon_call.png',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 40),
                                            child: Text(
                                              'Call',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: cnst
                                                      .appPrimaryMaterialColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: 1,
                                  color: Colors.grey[400],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/JustJoined');
                                  },
                                  child: Container(
                                    height: 80,
                                    width: (MediaQuery.of(context).size.width -
                                            15) /
                                        2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        //Text('0'), Text('Just Joined')
                                        Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child: Image.asset(
                                              'images/icon_redheart.png',
                                              height: 50,
                                              width: 50,
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Whatsapp',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: cnst
                                                    .appPrimaryMaterialColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                //side: BorderSide(color: cnst.appcolor)),
                                side: BorderSide(
                                    width: 0.70,
                                    color: cnst.appPrimaryMaterialColor),
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 20, bottom: 20),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/icn_earth.png',
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              controller: edtWebsite,
                                              scrollPadding: EdgeInsets.all(0),
                                              decoration: InputDecoration(
                                                  labelText: "Website",
                                                  labelStyle: TextStyle(
                                                      color: cnst
                                                          .appPrimaryMaterialColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Website"),
                                              enabled: false,
                                              minLines: 1,
                                              maxLines: 2,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.mail,
                                          size: 30,
                                          color: cnst.appPrimaryMaterialColor,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              controller: edtEmail,
                                              scrollPadding: EdgeInsets.all(0),
                                              decoration: InputDecoration(
                                                  labelText: "Email",
                                                  labelStyle: TextStyle(
                                                      color: cnst
                                                          .appPrimaryMaterialColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Email"),
                                              enabled: false,
                                              minLines: 1,
                                              maxLines: 2,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 30,
                                          color: cnst.appPrimaryMaterialColor,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              controller: edtAddress,
                                              scrollPadding: EdgeInsets.all(0),
                                              decoration: InputDecoration(
                                                  labelText: "Address",
                                                  labelStyle: TextStyle(
                                                      color: cnst
                                                          .appPrimaryMaterialColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  hintText: "Address"),
                                              enabled: false,
                                              minLines: 1,
                                              maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
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
              ),
      ),
    );
  }
}
