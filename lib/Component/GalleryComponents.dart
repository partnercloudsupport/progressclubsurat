import 'package:flutter/material.dart';

import 'package:progressclubsurat/Common/Constants.dart' as cnst;

class GalleryComponents extends StatefulWidget {

  var eventGallery;
  GalleryComponents(this.eventGallery);

  @override
  _GalleryComponentsState createState() => _GalleryComponentsState();
}

class _GalleryComponentsState extends State<GalleryComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: cnst.appcolor)),
          side: BorderSide(width: 0.10, color: cnst.appPrimaryMaterialColor),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Container(
          //padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(10.0),
            child: /*Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/9/9c/Hrithik_at_Rado_launch.jpg',
              height: 100,
              fit: BoxFit.fill,
            )*/
            widget.eventGallery["EventPhoto1"] != null
                ? FadeInImage.assetNetwork(
              placeholder: 'images/icon_events.jpg',
              image: widget.eventGallery["EventPhoto1"],
              fit: BoxFit.fill,
              height: 100,
            )
                : Image.asset(
              'images/icon_events.jpg',
              fit: BoxFit.fill,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
