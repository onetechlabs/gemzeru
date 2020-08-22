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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.green,
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
                    _buildCategory("Koin Tersisa", random.nextInt(500).toString()),
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
              SizedBox(height: 40),
              Text("Informasi Transaksi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
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
                onPressed: () {},
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
