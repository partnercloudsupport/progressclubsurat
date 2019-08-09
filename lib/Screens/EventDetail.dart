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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: widget.Event["Photo"] != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'images/icon_events.jpg',
                            image: widget.Event["Photo"],
                            fit: BoxFit.fill,
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                          )
                        : Image.asset(
                            'images/icon_events.jpg',
                            fit: BoxFit.fill,
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        //side: BorderSide(color: cnst.appcolor)),
                        side: BorderSide(
                            width: 0.20, color: cnst.appPrimaryMaterialColor),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
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
                                    'images/icon_event.png',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    //side: BorderSide(color: cnst.appcolor)),
                    side: BorderSide(
                        width: 0.20, color: cnst.appPrimaryMaterialColor),
                    borderRadius: BorderRadius.circular(
                      6.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '${widget.Event["ShortDesc"]}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            'Description',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15,
                                color: cnst.appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5, bottom: 5, left: 8),
                          child: Text(
                            '${widget.Event["LongDesc"]}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
