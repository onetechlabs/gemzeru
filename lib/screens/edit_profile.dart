import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gemzeru/util/data.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static Random random = Random();
  final _formKey = GlobalKey<FormState>();

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
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
                                          "Edit Profile",
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
                                            _buttonHeader("Kembali"),
                                            _buttonHeader("Simpan Data"),
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
                    Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Nama Lengkap",
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
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                ),
                                                initialValue: ProfileData.fullName,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Mohon untuk memasukan nama yang valid!';
                                                  } else if (value.length < 5) {
                                                    return 'Mohon untuk menuliskan minimal 5 huruf!';
                                                  } else if (value.length > 20) {
                                                    return 'Mohon untuk menuliskan maksimal 20 huruf!';
                                                  }
                                                  return null;
                                                },
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
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                                initialValue: ProfileData.phone,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Mohon untuk memasukan nomor yang valid!';
                                                  } else if (isNumeric(value)==false) {
                                                    return 'Harus Angka!';
                                                  } else if (value.length < 12) {
                                                    return 'Mohon untuk menuliskan minimal 12 angka!';
                                                  } else if (value.length > 16) {
                                                    return 'Mohon untuk menuliskan maksimal 16 angka!';
                                                  }
                                                  return null;
                                                },
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
                                              child: TextFormField(
                                                maxLines: 8,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                                initialValue: ProfileData.address,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Mohon untuk memasukan nama yang valid!';
                                                  } else if (value.length < 10) {
                                                    return 'Mohon untuk menuliskan minimal 10 huruf atau angka!';
                                                  } else if (value.length > 100) {
                                                    return 'Mohon untuk menuliskan maksimal 100 huruf atau angka!';
                                                  }
                                                  return null;
                                                },
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
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }

  Widget _buttonHeader(String text){
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
                  if(text =="Kembali"){
                    Navigator.pop(context);
                  }else if(text =="Simpan Data"){
                    print("data tersimpan");
                  }
                },
                child: Text(
                  "${text}".toUpperCase(),
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
}
