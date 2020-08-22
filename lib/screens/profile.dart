import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gemzeru/util/data.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              CircleAvatar(
                backgroundImage: AssetImage("assets/cm${random.nextInt(10)}.jpeg"),
                radius: 50,
              ),
              SizedBox(height: 10),
              Text(
                names[random.nextInt(10)],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "${job_position[0]}",
                style: TextStyle(),
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
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildCategory("Koin Saya"),
                  ],
                ),
              ),

              _listTransaction("Koin Masuk", "22 Ags 2020, 07:00 WIB","Anda Menambahkan ${random.nextInt(10).toString()} Koin"),
              _listTransaction("Koin keluar", "22 Ags 2020, 11:00 WIB","Anda Mengeluarkan ${random.nextInt(10).toString()} Koin"),
              _listTransaction("Koin Keluar", "22 Ags 2020, 14:00 WIB","Anda Mengeluarkan ${random.nextInt(10).toString()} Koin"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonBuyCoin(int qtyCoin){
    return Column(
      children: [
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)
          ),
          color: Colors.white,
          textColor: Colors.red,
          padding: EdgeInsets.all(10.0),
          onPressed: () {},
          child: Text(
            "Beli ${qtyCoin} Koin".toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategory(String title) {
    return Column(
      children: <Widget>[
        Text(
          random.nextInt(500).toString(),
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
