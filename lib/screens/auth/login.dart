import 'dart:async';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gemzeru/screens/auth/google_sign_in.dart';
import 'package:gemzeru/util/const.dart';
import 'package:gemzeru/screens/main_screen.dart';
import 'package:gemzeru/util/data.dart';

GoogleSignIn _googleSignIn = GoogleSignInBaseConfig.GoogleSignInVar;

class SignIn extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<SignIn> {
  static final List<String> imgSlider = [
    'slider0.png',
    'slider1.png',
    'slider2.png',
  ];

  final CarouselSlider autoPlayImage = CarouselSlider(
    items: imgSlider.map((fileImage) {
      return Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            'assets/images/${fileImage}',
            width: 10000,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList(),
    height: 150,
    autoPlay: true,
    enlargeCenterPage: true,
    aspectRatio: 2.0,
  );

  GoogleSignInAccount _currentUser;
  final random = new Random();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });

      saveData(_currentUser.id,_currentUser.email, _currentUser.displayName, _currentUser.photoUrl);
    });
    _googleSignIn.signInSilently();
  }

  Future<void> postProfile(String token, String id) async{
    final response = await http.post(Constants.backend_api+"member/show/"+id, body: {'token': token,});
    setState(() {
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var dataGamecode = jsonResponse['data']['record'][0]['gamecode'];
        var dataFullname = jsonResponse['data']['record'][0]['fullname'];
        var dataAddress = jsonResponse['data']['record'][0]['address'];
        var dataPhone = jsonResponse['data']['record'][0]['phone'];
        var dataStatus_active = jsonResponse['data']['record'][0]['status_active'];
        var dataCreatedat = jsonResponse['data']['record'][0]['created_at'];
        ProfileData.gameCode=dataGamecode.toString();
        ProfileData.fullName=dataFullname.toString();
        ProfileData.address=dataAddress.toString();
        ProfileData.phone=dataPhone.toString();
        ProfileData.status_active=dataStatus_active.toString();
        ProfileData.registered_at=dataCreatedat.toString();
        print(jsonResponse);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
  }

  Future<void> postLogin(String email) async{
    final response = await http.post(Constants.backend_api+"member-login", body: {'email': email,});
    setState(() {
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var dataId = jsonResponse['result']['user_id'];
        var dataToken = jsonResponse['result']['token'];
        ProfileData.id=dataId.toString();
        ProfileData.token=dataToken.toString();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
  }

  Future<void> saveData(id_g,em_g,dn_g,pu_g) async{
    ProfileData.idGoogle=_currentUser.id;
    ProfileData.photourlGoogle=_currentUser.photoUrl;
    ProfileData.emailGoogle=_currentUser.email;
    ProfileData.displaynameGoogle=_currentUser.displayName;

    await postLogin(_currentUser.email);
    await postProfile(ProfileData.token, ProfileData.id);
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        children: <Widget>[
          Container(
              constraints: BoxConstraints(minWidth: double.infinity, minHeight: 190),
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/congratulations.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null
          ),
          Padding(
              padding: EdgeInsets.only(top:20,bottom: 10,left: 10,right: 10),
              child: Center(
                child: Text(
                  "Selamat Datang",
                  style: TextStyle(fontSize: 25, color: Color.fromRGBO(23, 134, 190, 1)),
                  textAlign: TextAlign.center,
                ),
              )
          ),
          Center(
            child: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom:10.0),
                children: [
                  Center(
                    child: ListTile(
                      leading: GoogleUserCircleAvatar(
                        identity: _currentUser,
                      ),
                      title: Text(_currentUser.displayName ?? ''),
                      subtitle: Text(_currentUser.email ?? ''),
                    ),
                  ),
                ]
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:5,bottom: 30,left: 30,right: 30),
            child: Text(
              "Untuk melanjutkan ke tampilan utama silahkan klik lanjutkan untuk batal klik kembali",
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(23, 134, 190, 1)),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(top:5,bottom: 30,left: 30,right: 30),
                  child: RaisedButton.icon(
                      color: Colors.lightBlue,
                      onPressed: ()=>{
                        Navigator.push(context,MaterialPageRoute(builder: (context) => MainScreen()))
                      }, icon: Icon(
                    Icons.add_to_home_screen,
                    color: Colors.white,
                    size: 30.0,
                  ), label: Text("Lanjutkan", style: TextStyle(fontSize: 16, color: Colors.white)))
              ),
              Padding(
                  padding: EdgeInsets.only(top:5,bottom: 30),
                  child: RaisedButton.icon(
                      color: Colors.red,
                      onPressed: _handleSignOut, icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 30.0,
                  ), label: Text("Keluar", style: TextStyle(fontSize: 16, color: Colors.white)))
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minWidth: double.infinity, minHeight: 190),
            decoration: new BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/images/background${random.nextInt(2)}.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: new Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
                                    width: 100,// Not sure what to put here!
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: new Image.asset(
                                            'assets/images/MeetMe.png',
                                            fit: BoxFit.fill, // I thought this would fill up my Container but it doesn't
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:5),
                                  child: Text(
                                    "${Constants.appName} - Game Publisher",
                                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top:5,bottom:5),
                                    child: Container(
                                        width: 250,
                                        child: Center(
                                          child: Text(
                                            "Sudah punya google akun ?\nKlik tombol dibawah untuk masuk akun .",
                                            style: TextStyle(fontSize: 12, color: Color.fromRGBO(255, 255, 255, 1)),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                    )
                                )
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),


          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            autoPlayImage,
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                              child: Text(
                                "Masuk Akun",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromRGBO(23, 134, 190, 1)),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                                child: Container(
                                  width:200,
                                  child: GestureDetector(
                                    onTap: _handleSignIn,
                                    child: Image.asset('assets/images/login_google_long.png'),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),

        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Masuk Akun ke ${Constants.appName}'),
        ),
        body: SafeArea(
          child: _buildBody(),
        ));
  }
}