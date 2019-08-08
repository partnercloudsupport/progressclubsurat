import 'package:flutter/material.dart';
//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;

//components
import 'package:progressclubsurat/Component/NitificationComponents.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/Dashboard');
          /*Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.*/
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              // Make Custom App Bar
              Container(
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.only(left: 10),
                //color: Colors.black,
                height: 50,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/Dashboard');
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: cnst.appPrimaryMaterialColor,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: Text(
                        'Notification',
                        style: TextStyle(
                            color: cnst.appPrimaryMaterialColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              //Make ListView
              Container(
                height: MediaQuery.of(context).size.height - 75,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return NitificationComponents();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
