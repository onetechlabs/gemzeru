import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class PostItem extends StatefulWidget {
  final String version;
  final String cover_image;
  final String category;
  final String title;
  final String description;

  PostItem({
    Key key,
    @required this.version,
    @required this.cover_image,
    @required this.category,
    @required this.title,
    @required this.description,

  }) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: ()=>{},
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "${widget.title}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "${widget.category}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),
            Card(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "${widget.cover_image}",
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left:10.0, right:5.0),
                                child: Text(
                                  "Versi ke ${widget.version}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top:15.0, bottom:15.0, left:5.0, right:5.0),
                            child: Container(
                              child: Text(
                                "${widget.description}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
