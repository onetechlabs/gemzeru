import 'package:flutter/material.dart';
import 'package:gemzeru/components/post_item.dart';
import 'package:gemzeru/util/data.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permainan"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          Map post = posts[index];
          return PostItem(
            version: post['version'],
            gameCover: post['gameCover'],
            category: post['category'],
            gameName: post['gameName'],
            desc: post['desc'],
          );
        },
      ),
    );
  }

}
