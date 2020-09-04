import 'dart:math';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:gemzeru/util/data.dart';
import 'package:gemzeru/screens/edit_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:gemzeru/util/const.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int totd = 0;
  static Random random = Random();
  bool dialVisible = true;
  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }
  void initState() {
    super.initState();
    checkGold(ProfileData.token.toString(),ProfileData.gameCode.toString());
  }

  Future<void> addGold(String token, String gamecode, String a_gold) async{
    final response = await http.post(Constants.backend_api+"payment-instrument/add/"+a_gold+"/gold/to/"+gamecode, body: {'token': token,'description':'Top Up'});

    if (response.statusCode == 200) {
      setState(() {
        totd = totd+int.parse(a_gold);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> checkGold(String token, String gamecode) async{
    final response = await http.post(Constants.backend_api+"payment-instruments/showby-gamecode/"+gamecode+"/showby-payment-instrument/gold", body: {'token': token,'is_used':'no'});

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = convert.jsonDecode(response.body);
        totd = jsonResponse['data']['total_data'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Icon(Icons.refresh),
              backgroundColor: Colors.blueGrey,
              label: 'Check Gold',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => {
                checkGold(ProfileData.token.toString(),ProfileData.gameCode.toString()),
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.edit),
              backgroundColor: Colors.green,
              label: 'Ubah Profil',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => {
                Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfile())),
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.cancel),
            backgroundColor: Colors.red,
            label: 'Kembali',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => {
              Navigator.of(context).popUntil((route) => route.isFirst),
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 30),
                constraints: BoxConstraints(minWidth: double.infinity, minHeight: 165),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage("assets/images/background${random.nextInt(2)}.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: new Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      ProfileData.photourlGoogle
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:5),
                                  child: Text(
                                    ProfileData.fullName,
                                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:5,bottom:5),
                                  child: Text(
                                    ProfileData.emailGoogle,
                                    style: TextStyle(fontSize: 12, color: Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      _buttonBuyCoin(5),
                                      _buttonBuyCoin(10),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildCategory("Gold", totd.toString()),
                    _buildCategory("Game Code", ProfileData.gameCode),
                    _buildCategory("Status Aktif", ProfileData.status_active.toUpperCase()),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Nomor Kontak",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(top:15.0, bottom:15.0, left:5.0, right:5.0),
                                      child: Container(
                                        child: Text(
                                          ProfileData.phone,
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
                    ListTile(
                      title: Text(
                        "Alamat",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(top:15.0, bottom:15.0, left:5.0, right:5.0),
                                      child: Container(
                                        child: Text(
                                          ProfileData.address,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonBuyCoin(int qtyCoin){
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)
                ),
                color: Colors.white,
                textColor: Colors.red,
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  addGold(ProfileData.token,ProfileData.gameCode,qtyCoin.toString());
                },
                child: Text(
                  "Beli ${qtyCoin} Koin".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildCategory(String title, String value) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _listTransaction(String transactionTitle, String date, String desc){
    return Column(
      children: [
        ListTile(
          title: Text(
            transactionTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            date,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top:15.0, bottom:15.0, left:5.0, right:5.0),
                          child: Container(
                            child: Text(
                              desc,
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
    );
  }
}
