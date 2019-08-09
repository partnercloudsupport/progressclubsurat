import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;

class EventDetail extends StatefulWidget {
  var Event;

  EventDetail({Key key, this.Event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
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
          'Event Details',
          style: TextStyle(
              color: cnst.appPrimaryMaterialColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.Event["Title"]}',
                  style: TextStyle(
                      fontSize: 16,
                      color: cnst.appPrimaryMaterialColor,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      'images/icon_Event.png',
                      height: 18,
                      width: 18,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '${widget.Event["EventDate"].substring(8, 10)}-'
                        "${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.Event["EventDate"].substring(0, 10)).toString()))}-${widget.Event["EventDate"].substring(0, 4)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: cnst.appPrimaryMaterialColor,
                        ),
                      ),
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: widget.Event["Photo"] != null
                      ? FadeInImage.assetNetwork(
                          placeholder: 'images/icon_Events.jpg',
                          image: widget.Event["Photo"],
                          fit: BoxFit.fill,
                          height: 180,
                          width: MediaQuery.of(context).size.width - 20,
                        )
                      : Image.asset(
                          'images/icon_Events.jpg',
                          fit: BoxFit.fill,
                          height: 180,
                          width: MediaQuery.of(context).size.width - 20,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    '${widget.Event["LongDesc"]}',
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
