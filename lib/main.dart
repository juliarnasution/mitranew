import 'package:flutter/material.dart';
import 'beranda.dart';
import 'package:http/http.dart' as http;
import 'takeId.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutternew/home/home.dart';


void main() => runApp(MyApp());

String passingIdMitra = "";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: Login(),
      routes: {
        "/keluar":(_) => new Login(),
        "/beranda" : (_) => new Beranda(usernameMitra: passingIdMitra,),
        "/home" :(_) => new Home(),
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _formKeyBottomSheet = new GlobalKey<FormState>();
  VoidCallback _showBottomSheetCallBack;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController nohpController = new TextEditingController();

  String nama, alamat, email, nohp;
  String username, password;
  var data;
  String msgFromPhp = "";
  bool passVisible;

  @override
  void initState() {
    super.initState();
    passVisible = true;
    _showBottomSheetCallBack = _showBottomSheet;
  }

  Future<List> getLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var response = await http.post(
          Uri.encodeFull("https://pocky-fifties.000webhostapp.com/login.php"),
          body: {
            "userid": usernameController.text,
            "password": passwordController.text
          });
     
      var convertDataToJson = json.decode(response.body);
      if (convertDataToJson.length == 1) {
        Navigator.pushReplacementNamed(context, '/home');
        print(username);
        setState(() {
         passingIdMitra  = username ;
        });
        
      } else {
        setState(() {
          msgFromPhp = "Ada kesalahan Login";  
        });
      }
       _formKey.currentState.reset();
      // setState(() {
      //    var convertDataToJson = json.decode(response.body);
      //    data = convertDataToJson['result'];
      // });

      // return convertDataToJson;
    }
  }

  void _addData() {
    if (_formKeyBottomSheet.currentState.validate()) {
      _formKeyBottomSheet.currentState.save();

      var url = "https://pocky-fifties.000webhostapp.com/addMitra.php";
      http.post(url,
          body: {"nama": nama, "alamat": alamat, "email": email, "nohp": nohp});

      _formKeyBottomSheet.currentState.reset();

      // namaController.text = "";
      // alamatController.text = "";
      // emailController.text = "";
      // nohpController.text = "";

      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     duration: const Duration(seconds: 2),
      //     content: Text('Data tersimpan')));
      // Navigator.pop(context, false);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TakeId(phone: nohp)));

        //   Navigator.of(context).push(
        //       MaterialPageRoute(
        //           builder: (context) => TakeId(phone: nohp)));
      });
    }
  }

  void _showBottomSheet() {
    setState(() {
      _showBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return Container(
            margin: EdgeInsets.all(40.0),
            child: new Form(
              key: _formKeyBottomSheet,
              child: new ListView(
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextFormField(
                    validator: (input) =>
                        input.length == 0 ? 'Form Nama harus diisi !' : null,
                    onSaved: (val) => nama = val,
                    controller: namaController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                    ),
                  ),
                  TextFormField(
                    validator: (input) =>
                        input.length == 0 ? 'Form Alamat harus diisi !' : null,
                    onSaved: (val) => alamat = val,
                    controller: alamatController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                    ),
                  ),
                  TextFormField(
                    validator: (input) =>
                        !input.contains('@') ? 'Email tidak sesuai' : null,
                    onSaved: (val) => email = val,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                    ),
                  ),
                  TextFormField(
                    validator: (input) => input.length == 0
                        ? 'Form Nomer HP harus diisi !'
                        : null,
                    onSaved: (val) => nohp = val,
                    controller: nohpController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Nomer HP',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                    ),
                  ),
                  FlatButton.icon(
                    color: Colors.lightBlue,
                    splashColor: Colors.red,
                    label: Text(
                      'Simpan',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _addData();
                      //Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(40.0),
          child: new ListView(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50.0,
                child: new Image.asset(
                  'img/logo.png',
                  scale: 3.0,
                ),
              ),
              SizedBox(height: 10.0),
              msgFromPhp == "" ? Text('Selamat Datang di Bakubantu',textAlign: TextAlign.center,) :  Text(msgFromPhp),
              new Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      validator: (input) =>
                          input.length == 0 ? 'Username tidak boleh kosong? !' : null,
                      onSaved: (val) => username = val,
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.green,
                        )),
                      ),
                    ),
                    TextFormField(
                      validator: (input) => input.length == 0
                          ? 'Password tidak boleh kosong !'
                          : null,
                      onSaved: (val) => password = val,
                      controller: passwordController,
                      obscureText: passVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(passVisible?Icons.visibility:Icons.visibility_off, color:Theme.of(context).primaryColorDark),
                          onPressed: (){
                            setState(() {
                             passVisible =!passVisible; 
                            });
                          },
                        ),
                        labelText: 'Password',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.green,
                        )),
                      ),
                    ),
                    FlatButton.icon(
                      color: Colors.blue,
                      splashColor: Colors.blue[300],
                      label: Text(
                        'Masuk',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        getLogin();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Belum punya akun?   '),
                  new Expanded(
                    child: RaisedButton(
                      color: Colors.grey,
                      splashColor: Colors.red,
                      padding: EdgeInsets.only(right: 2.0),
                      child: Text('Daftar Sekarang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      onPressed: () {
                         _showBottomSheetCallBack();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
