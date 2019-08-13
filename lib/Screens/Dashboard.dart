import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:avatar_glow/avatar_glow.dart';

//calendar  lib
import 'package:intl/date_symbol_data_local.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';
import 'package:progressclubsurat/pages/Ask.dart';
import 'package:progressclubsurat/pages/Home.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'AnimatedBottomBar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:soundpool/soundpool.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:progressclubsurat/Screens/MultipleEventList.dart';

// Example holidays

class Dashboard extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
        text: "Home",
        iconData: Icons.home,
        color: cnst.appPrimaryMaterialColor),
    BarItem(
        text: "Assignments",
        iconData: Icons.assignment,
        color: Colors.yellow.shade900),
    BarItem(text: "Ask", iconData: Icons.announcement, color: Colors.teal),
    BarItem(
        text: "Notification",
        iconData: Icons.notifications_active,
        color: Colors.deepOrange.shade600),
  ];

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleEvents;
  Map<DateTime, List> _visibleHolidays;
  AnimationController _controller;
  String barcode = "", currentDay = "";
  var currentMoth = "", curentYear = "";

  //loading var
  bool isLoading = false;

  String memberName = "",
      memberCmpName = "",
      memberPhoto = "",
      memberId = "",
      memberType = "",
      chapterId = "";
  int soundId;
  int _currentIndex = 0;
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  static var now = new DateTime.now();
  var date = new DateFormat("yyyy-MM-dd").format(now);
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String fcmToken = "";

  @override
  void initState() {
    super.initState();
    //_selectedDay = DateTime.now();

    getLocalData();

    _firebaseMessaging.getToken().then((String token) {
      print("Original Token:$token");
      var tokendata = token.split(':');
      setState(() {
        fcmToken = token;
        sendFCMTokan();
      });
      print("FCM Token : $fcmToken");
    });
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(cnst.Session.MemberId);
    prefs.remove(cnst.Session.ChapterId);
    prefs.remove(cnst.Session.memId);
    prefs.remove(cnst.Session.Photo);
    prefs.remove(cnst.Session.CompanyName);
    prefs.remove(cnst.Session.memId);

    Navigator.pushReplacementNamed(context, "/Login");
  }

  //send fcm token
  sendFCMTokan() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future res = Services.SendTokanToServer(fcmToken);
        res.then((data) async {}, onError: (e) {
          print("Error : on Login Call");
        });
      }
    } on SocketException catch (_) {}
  }

  getSound() async {
    int sound = await rootBundle
        .load("sounds/beep_smooth.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });

    setState(() {
      soundId = sound;
    });
  }

  getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getString(Session.MemberId);
      chapterId = prefs.getString(Session.ChapterId);
      memberName = prefs.getString(Session.Name);
      memberCmpName = prefs.getString(Session.CompanyName);
      memberPhoto = prefs.getString(Session.Photo);
      memberType = prefs.getString(Session.Type);
      //print(memberName);
    });
  }

  final List<Widget> _children = [
    Home(),
    Home(),
    Ask(),
    Home(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //show event dialog


  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      var qrtext = barcode.toString().split(",");
      //&& qrtext.length > 2
      if (qrtext != null)
        setState(() {
          print(qrtext[1].toString());
          String eventId = qrtext[0].toString();
          //EventId = qrtext[0].toString();
          //UserId = qrtext[1].toString();
          //UserName = qrtext[2].toString();
          sendEventAttendance(eventId);
        });
      await pool.play(soundId);
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
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
                //Navigator.pushReplacementNamed(context, '/Login');
              },
            ),
          ],
        );
      },
    );
  }

  //event Attendance
  sendEventAttendance(String eventId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var data = {
          'MemberId': memberId,
          'EventId': eventId,
        };
        Services.sendEventAttendance(data).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data.Data == "1") {
            signUpDone("Attendance Send Successfully");
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
  }

  saveAndNavigator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.memId, memberId);
    if (memberType.toLowerCase() == "guest") {
      Navigator.pushNamed(context, '/GuestProfile');
    } else {
      Navigator.pushNamed(context, '/MemberProfile');
    }
  }

  getLocalDataFrom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberName = prefs.getString(Session.Name);
      memberCmpName = prefs.getString(Session.CompanyName);
      memberPhoto = prefs.getString(Session.Photo);
      //print(memberName);
    });
  }

  String getName() {
    getLocalDataFrom();
    return memberName;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          //color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: (){
              saveAndNavigator();
            },
            child: Row(
              children: <Widget>[
                AvatarGlow(
                  glowColor: Colors.white,
                  endRadius: 27.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 100.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: ClipOval(
                        child: memberPhoto != null
                            ? FadeInImage.assetNetwork(
                                placeholder: 'images/icon_user.png',
                                image: memberPhoto.contains("http")
                                    ? memberPhoto
                                    : "http://pmc.studyfield.com/" +
                                        memberPhoto,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/icon_user.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                      ),
                      radius: 20.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${getName()}",
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                      ),
                      Text(
                        '$memberCmpName',
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              scan();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'images/icon_scanner.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: memberType.toLowerCase() == "guest"
            ? ListView(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.directions,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Member Directory"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/Directory');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.assignment,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Event"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/EventList');
                        //Navigator.pushReplacementNamed(context, '/EventList');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.notifications,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Notification"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, '/NotificationScreen');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.feedback,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Feedback"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/FeedbackScreen');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.exit_to_app,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Logout"),
                      onTap: () {
                        Navigator.pop(context);
                        _logout();
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              )
            : ListView(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.directions,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Member Directory"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/Directory');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.file_download,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Download"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/Download');
                        //Navigator.pushReplacementNamed(context, '/Download');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.assignment,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Event"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/EventList');
                        //Navigator.pushReplacementNamed(context, '/EventList');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.assignment,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Assignments"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/Assignments');
                        //Navigator.pushReplacementNamed(context, '/Assignments');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Image.asset(
                        'images/icon_ask.png',
                        color: cnst.appPrimaryMaterialColor,
                        height: 28,
                        width: 28,
                      ),
                      title: new Text("Ask"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/AskList');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.notifications,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Notification"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, '/NotificationScreen');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.feedback,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Feedback"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/FeedbackScreen');
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  new ListTile(
                      leading: Icon(Icons.exit_to_app,
                          color: cnst.appPrimaryMaterialColor),
                      title: new Text("Logout"),
                      onTap: () {
                        Navigator.pop(context);
                        _logout();
                      }),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: Duration(milliseconds: 350),
          onBarTab: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}