import 'dart:io';

import 'package:flutter/material.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Services.dart';

//Componnets Dart File
import 'package:progressclubsurat/Component/MultipleEventListComponents.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class MultipleEventList extends StatefulWidget {
  final String date,chapterId;
  const MultipleEventList({Key key, this.date,this.chapterId}) : super(key: key);

  @override
  _MultipleEventListState createState() => _MultipleEventListState();
}

class _MultipleEventListState extends State<MultipleEventList> {

  bool isLoading = false;
  List listMeeting = new List();
  List listEvent = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.date);
    getMeetingFromServer();
    getEventFromServer();
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

  getMeetingFromServer() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetMeetingListByDate(widget.chapterId, widget.date);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              isLoading = false;
              listMeeting = data;
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

  getEventFromServer() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetEventByDate(widget.date);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              isLoading = false;
              listEvent = data;
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Meetings',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  'Events',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          title: Text(
            'Schedule List',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Make ListView
                  Container(
                    height: 500,
                    margin: EdgeInsets.only(top: 10),
                    //height: MediaQuery.of(context).size.height - 75,
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      itemHeight: 500,
                      itemBuilder: (BuildContext context, int index) {
                        return MultipleEventListComponents(listMeeting[index]);
                      },
                      itemCount: listMeeting.length,
                      pagination: new SwiperPagination(),
                      //control: new SwiperControl(),
                      viewportFraction: 0.85,
                      scale: 0.9,
                    ),
                  )
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
