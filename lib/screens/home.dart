import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gemzeru/components/post_item.dart';
import 'package:gemzeru/util/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:gemzeru/util/const.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List posts = List();
  int cpage=1;
  bool dialVisible = true;
  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
  @override
  void initState() {
    super.initState();
    postGames(ProfileData.token.toString(),"1");
  }

  void loadDataGames(int cpage, String sym) async{
    if(sym=="+"){
      cpage++;
      await postGames(ProfileData.token.toString(),cpage.toString());
      print("load game ++");
    }else if(sym=="-"){
      cpage--;
      await postGames(ProfileData.token.toString(),cpage.toString());

      print("load game --");
    }
  }

  Future<void> postGames(String token, String page) async{
    final response = await http.post(Constants.backend_api+"games/", body: {'token': token, 'page':page});

    if (response.statusCode == 200) {
      if (!mounted) return;
      setState(() {
        var jsonResponse = convert.jsonDecode(response.body);
        var datas = jsonResponse['data']['records'];
        if(datas.length!=0) {
          posts = datas as List;
        }
        print(datas.length.toString()+" datas");
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permainan"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.skip_next),
              backgroundColor: Colors.green,
              label: 'Next',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => {
                loadDataGames(cpage, "+"),
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.skip_previous
            ),
            backgroundColor: Colors.red,
            label: 'Previous',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => {
              loadDataGames(cpage, "-"),
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          Map post = posts[index];
          return PostItem(
            version: post['version'],
            cover_image: post['cover_image'],
            category: post['category'],
            title: post['title'],
            description: post['description'],
          );
        },
      ),
    );
  }

}
