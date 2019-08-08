import 'package:flutter/material.dart';
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Constants.dart';
import 'package:progressclubsurat/Screens/MemberDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberDirectoryComponent extends StatefulWidget {
  var memberList;

  //images/icon_member.jpg

  MemberDirectoryComponent(this.memberList);

  @override
  _MemberDirectoryComponentState createState() =>
      _MemberDirectoryComponentState();
}

class _MemberDirectoryComponentState extends State<MemberDirectoryComponent> {

  saveAndNavigator() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.memId,widget.memberList["Id"].toString());
    Navigator.pushNamed(context, '/MemberDetails');
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        saveAndNavigator();
        /*Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MemberDetails()));*/
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: cnst.appcolor)),
            side: BorderSide(width: 0.50, color: cnst.appPrimaryMaterialColor),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: widget.memberList["Image"] != null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'images/icon_user.png',
                              image: "http://pmc.studyfield.com/" +
                                  widget.memberList["Image"],
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
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.memberList["Name"]}',
                            style: TextStyle(
                                color: cnst.appPrimaryMaterialColor,
                                fontSize: 18),
                          ),
                          Text('${widget.memberList["CompanyName"]}'),
                        ],
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
