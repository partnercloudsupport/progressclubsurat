import 'package:flutter/material.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;

//Componnets Dart File
import 'package:progressclubsurat/Component/MultipleEventListComponents.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class MultipleEventList extends StatefulWidget {
  @override
  _MultipleEventListState createState() => _MultipleEventListState();
}

class _MultipleEventListState extends State<MultipleEventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Make Custom App Bar
            Container(
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.only(left: 10),
              //color: Colors.black,
              height: 50,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Text(
                      'Member Directory',
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
              height: 500,
              //height: MediaQuery.of(context).size.height - 75,
              width: MediaQuery.of(context).size.width,
              child:
                  /*ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return MultipleEventListComponents();
                  }),*/
                  Swiper(
                itemHeight: 500,
                itemBuilder: (BuildContext context, int index) {
                  return MultipleEventListComponents();
                },
                itemCount: 10,
                pagination: new SwiperPagination(),
                //control: new SwiperControl(),
                viewportFraction: 0.85,
                scale: 0.9,
              ),
            )
          ],
        ),
      ),
    );
  }
}
