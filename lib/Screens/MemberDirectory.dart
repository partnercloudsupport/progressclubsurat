import 'dart:io';

import 'package:flutter/material.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';

//Components
import 'package:progressclubsurat/Component/MemberDirectoryComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberDirectory extends StatefulWidget {
  @override
  _MemberDirectoryState createState() => _MemberDirectoryState();
}

class _MemberDirectoryState extends State<MemberDirectory> {
  //loading var
  bool isLoading = true;
  List list = new List();
  List searchlist=new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDirectoryFromServer();
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

  getDirectoryFromServer() async {
    try {
      searchlist.clear();
      //check Internet Connection
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String ChapterId = prefs.getString(Session.ChapterId);

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetChapterMemberList(ChapterId);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              isLoading = false;
              list = data;
            });
          } else {
            showMsg("Try Again.");
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


  //search Code
  TextEditingController _controller = TextEditingController();

  final globalKey = new GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text(
    'Member Directory',
    style: TextStyle(
        color: cnst.appPrimaryMaterialColor,
        fontSize: 18,
        fontWeight: FontWeight.w600),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Member Directory',
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
            : list.length != 0 && list != null
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MemberDirectoryComponent(list[index]);
                    })
                : Container(
                    child: Center(
                        child: Text('No Data Found.',
                            style: TextStyle(
                                color: cnst.appPrimaryMaterialColor,
                                fontSize: 20))),
                  ),
      ),
    );
  }
}
