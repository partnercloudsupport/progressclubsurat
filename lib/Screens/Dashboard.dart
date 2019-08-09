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

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'AnimatedBottomBar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:soundpool/soundpool.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  /*DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],*/
};

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
  List _selectedEvents;
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

    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];
    _visibleEvents = _events;
    _visibleHolidays = _holidays;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _controller.forward();

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

    var now = new DateTime.now();
    var lastDayDateTime = (now.month < 12)
        ? new DateTime(now.year, now.month + 1, 0)
        : new DateTime(now.year + 1, 1, 0);

    String sdate = "${lastDayDateTime.year}-${lastDayDateTime.month}-01";
    String edate =
        "${lastDayDateTime.year}-${lastDayDateTime.month}-${lastDayDateTime.day}";
    getDashboardData(chapterId, sdate, edate);
  }

  final List<Widget> _children = [
    //Home(),
    //MemberServices(),
    //Offers(),
    //More(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
    //print(_selectedDay);
    if (events.length == 1) {
      showEventDialog(_selectedEvents);
    } else if (events.length > 1) {
      Navigator.pushNamed(context, '/MultipleEventList');
    }
  }

  //show event dialog
  showEventDialog(List event) {
    Dialog EventDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "STAFF TRAINING",
                  style: TextStyle(
                      color: cnst.appPrimaryMaterialColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Progress Club 1',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'A training agenda is, basically, a series or outline of '
                'activities or training process.',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.50),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Training Date & Time',
                    style: TextStyle(
                        color: cnst.appPrimaryMaterialColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'From :',
                          style: TextStyle(
                              color: cnst.appPrimaryMaterialColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' 24-Jan-2019',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'To :',
                          style: TextStyle(
                              color: cnst.appPrimaryMaterialColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' 24-Jan-2019',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'On 5 PM to 7 PM',
                          style: TextStyle(
                              color: cnst.appPrimaryMaterialColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Venue At :',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cnst.appPrimaryMaterialColor,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Bhatar Community hall, Althan, Surat-395008',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Registration Charges : ${cnst.Inr_Rupee} 250/-',
                style: TextStyle(
                    color: cnst.appPrimaryMaterialColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: cnst.appPrimaryMaterialColor,
                          minWidth: MediaQuery.of(context).size.width - 10,
                          onPressed: () {
                            //if (isLoading == false) this.SaveOffer();
                            //Navigator.pushReplacementNamed(context, '/Dashboard');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: cnst.appPrimaryMaterialColor,
                          minWidth: MediaQuery.of(context).size.width - 10,
                          onPressed: () {
                            //if (isLoading == false) this.SaveOffer();
                            //Navigator.pushReplacementNamed(context, '/Dashboard');
                          },
                          child: Text(
                            "Register & Pay",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => EventDialog);
  }

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

  String setdata() {
    getLocalData();
    //densih ubhal
    return memberName;
  }

  saveAndNavigator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.memId, memberId);
    if (memberType == "guest") {
      Navigator.pushNamed(context, '/GuestProfile');
    } else {
      Navigator.pushNamed(context, '/MemberProfile');
    }
  }

  getDashboardData(String chapterId, String sdate, String edate) async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetDashboard(chapterId, sdate, edate);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              isLoading = false;
              //list = data;
            });

            _events = {};
            for (int i = 0; i < data.length; i++) {
              _events.addAll({
                DateTime.parse(data[i]["Date"].toString()): data[i]["EventList"]
              });
            }

            /*_events = {
              DateTime.parse('2019-07-01'): ['Event A0'],
              DateTime.parse('2019-07-04'): ['Event A0', 'Event B0', 'Event C0'],
              DateTime.parse('2019-07-06'): ['Event A0', 'Event B0', 'Event C0'],
              DateTime.parse('2019-07-10'): ['Event A0'],
            };*/

            _selectedEvents = _events[_selectedDay] ?? [];
            _visibleEvents = _events;
            _visibleHolidays = _holidays;

            _controller = AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 100),
            );
            _controller.forward();
          } else {
            setState(() {
              isLoading = false;
            });
            //showMsg("Try Again.");
          }
        }, onError: (e) {
          print("Error : on getDashboardData $e");
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          //color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  saveAndNavigator();
                },
                child: AvatarGlow(
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
                      child:
                          /*ClipOval(
                          child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/9/9c/Hrithik_at_Rado_launch.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ))*/
                          ClipOval(
                        child: memberPhoto != null
                            ? FadeInImage.assetNetwork(
                                placeholder: 'images/icon_user.png',
                                image:
                                    "http://pmc.studyfield.com/" + memberPhoto,
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
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Name",
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
        child: ListView(
          children: <Widget>[
            new ListTile(
                leading: Icon(Icons.directions),
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
                leading: Icon(Icons.file_download),
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
                leading: Icon(Icons.assignment),
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
                leading: Icon(Icons.assignment),
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
                  color: Colors.grey[600],
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
                leading: Icon(Icons.notifications),
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
                leading: Icon(Icons.feedback),
                title: new Text("Feedback"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/FeedbackScreen');
                }),
            Divider(
              height: 2,
              color: Colors.black,
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: Duration(milliseconds: 350),
          onBarTab: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),*/
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 25),
                      //height:MediaQuery.of(context).size.height/4.5,
                      height: height > 550.0
                          ? MediaQuery.of(context).size.height / 4.3
                          : MediaQuery.of(context).size.height / 4.6,
                      width: MediaQuery.of(context).size.width,
                      color: cnst.appPrimaryMaterialColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${date.substring(8, 10)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: height > 550.0 ? 55 : 35,
                                  ),
                                ),
                                Text(
                                  '${new DateFormat.EEEE().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(date.substring(0, 10)).toString()))}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 2,
                            margin: EdgeInsets.only(top: 0),
                            height: height > 550.0 ? 90 : 60,
                            color: Colors.grey[300].withOpacity(0.5),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(date.substring(0, 10)).toString()))},',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height > 550.0 ? 40 : 20,
                                  ),
                                ),
                                Text(
                                  '${date.substring(0, 4)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height > 550.0 ? 40 : 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipper: displayDateClipper(),
                  ),
                  // Switch out 2 lines below to play with TableCalendar's settings
                  //-----------------------
                  _buildTableCalendar(),
                  // _buildTableCalendarWithBuilders(),
                  //const SizedBox(height: 8.0),
                  //Expanded(child: _buildEventList()),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: isLoading ? LoadinComponent() : Container())
            ],
          ),
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      holidays: _visibleHolidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        /*CalendarFormat.twoWeeks: '2 weeks',
        CalendarFormat.week: 'Week',*/
      },
      calendarStyle: CalendarStyle(
        selectedColor: cnst.appPrimaryMaterialColor,
        todayColor: cnst.appPrimaryMaterialColor[200],
        markersColor: Colors.deepOrange,
        //markersMaxAmount: 7,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: cnst.appPrimaryMaterialColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      print(first);
      print(last);

      getDashboardData(chapterId, first.toString().substring(0,10), last.toString().substring(0,10));

      _visibleEvents = Map.fromEntries(
        _events.entries.where(
          (entry) =>
              entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );

      _visibleHolidays = Map.fromEntries(
        _holidays.entries.where(
          (entry) =>
              entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );
    });
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}

class displayDateClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();

    path.lineTo(0.0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
