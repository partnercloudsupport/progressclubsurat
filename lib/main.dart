import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;

//Screen Dart File
import 'package:progressclubsurat/Screens/Splash.dart';
import 'package:progressclubsurat/Screens/Login.dart';
import 'package:progressclubsurat/Screens/SignUp.dart';
import 'package:progressclubsurat/Screens/Dashboard.dart';
import 'package:progressclubsurat/Screens/MemberDirectory.dart';
import 'package:progressclubsurat/Screens/MemberDetails.dart';
import 'package:progressclubsurat/Screens/ForgotPassword.dart';
import 'package:progressclubsurat/Screens/Directory.dart';
import 'package:progressclubsurat/Screens/Download.dart';
import 'package:progressclubsurat/Screens/Assignments.dart';
import 'package:progressclubsurat/Screens/NotificationScreen.dart';
import 'package:progressclubsurat/Screens/OtpVerification.dart';
import 'package:progressclubsurat/Screens/FeedbackScreen.dart';
import 'package:progressclubsurat/Screens/EventList.dart';
import 'package:progressclubsurat/Screens/EventDetail.dart';
import 'package:progressclubsurat/Screens/AskList.dart';
import 'package:progressclubsurat/Screens/TaskList.dart';
import 'package:progressclubsurat/Screens/MemberProfile.dart';
import 'package:progressclubsurat/Screens/EditProfile.dart';
import 'package:progressclubsurat/Screens/EventGallery.dart';
import 'package:progressclubsurat/Screens/MultipleEventList.dart';
import 'package:progressclubsurat/Screens/CommitieScreen.dart';
import 'package:progressclubsurat/Screens/DirectorySearch.dart';
import 'package:progressclubsurat/Screens/GuestProfile.dart';
import 'package:progressclubsurat/Screens/GuestDetails.dart';

//void main() => runApp(MyApp());
void main(){
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          print("onMessage");
          print(message);
          //print(message["notification"]["title"]);
          //_showItemDialog(message, context);
        },
        onResume: (Map<String, dynamic> message) {
          print("onResume");
          print(message);
        },
        onLaunch: (Map<String, dynamic> message) {
          print("onLaunch");
          print(message);
        }
    );

    //For Ios Notification
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true)
    );

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings){
      print("Setting reqistered : $settings");
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: cnst.appPrimaryMaterialColor
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Club Surat',
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
        '/Dashboard': (context) => Dashboard(),
        '/MemberDirectory': (context) => MemberDirectory(),
        '/MemberDetails': (context) => MemberDetails(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/Directory': (context) => Directory(),
        '/Download': (context) => Download(),
        '/Assignments': (context) => Assignments(),
        '/NotificationScreen': (context) => NotificationScreen(),
        '/OtpVerification': (context) => OtpVerification(),
        '/FeedbackScreen': (context) => FeedbackScreen(),
        '/EventList': (context) => EventList(),
        '/EventList': (context) => EventDetail(),
        '/AskList': (context) => AskList(),
        '/TaskList': (context) => TaskList(),
        '/MemberProfile': (context) => MemberProfile(),
        '/EditProfile': (context) => EditProfile(),
        '/EventGallery': (context) => EventGallery(),
        '/MultipleEventList': (context) => MultipleEventList(),
        '/CommitieScreen': (context) => CommitieScreen(),
        '/DirectorySearch': (context) => DirectorySearch(),
        '/GuestProfile': (context) => GuestProfile(),
        '/GuestDetails': (context) => GuestDetails(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: cnst.appPrimaryMaterialColor,
        accentColor: Colors.black,
        buttonColor: Colors.deepPurple,
      ),
    );
  }
}
