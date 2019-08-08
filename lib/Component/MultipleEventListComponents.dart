import 'package:flutter/material.dart';

import 'package:progressclubsurat/Common/Constants.dart' as cnst;

class MultipleEventListComponents extends StatefulWidget {
  @override
  _MultipleEventListComponentsState createState() =>
      _MultipleEventListComponentsState();
}

class _MultipleEventListComponentsState
    extends State<MultipleEventListComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
          border:
          Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6)),
          color: cnst.appPrimaryMaterialColor),
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
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[600]),
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
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[600]),
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 14.0),
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
    );
  }
}
