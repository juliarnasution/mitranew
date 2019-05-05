import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'updateJasa.dart';
import 'main.dart';

class TakeId extends StatefulWidget {
  final phone;

  const TakeId({Key key, this.phone}) : super(key: key);

  @override
  _TakeIdState createState() => _TakeIdState();
}

class _TakeIdState extends State<TakeId> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController passwordController = new TextEditingController();

  String password;
  var id;
  bool passVisible;

  @override
  void initState() {
    super.initState();
    passVisible = true;
  }


  Future getID() async {
    final response = await http.get(
        "https://pocky-fifties.000webhostapp.com/getIdMitra.php?nohp=${widget.phone}");
    // print(widget.phone);
    return json.decode(response.body);
  }

  void _setPasswordMitra() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var url =
          "https://pocky-fifties.000webhostapp.com/updatePasswordMitra.php";
      http.post(url, body: {"password": password, "id": id});
      print(id);
      _formKey.currentState.reset();
      //passwordController.text = "";

      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Password Tersimpan')));

      
      Future.delayed(Duration(seconds: 2), () {
       Navigator.of(context).pushReplacement( MaterialPageRoute(
                builder: (context) => Updatejasa( id: id, username: passingIdMitra,)));
      // Navigator.pop(context);  
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => Updatejasa(
      //             id: id,
      //           )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: getID(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            // print(snapshot.data[0]['idmitra']);
             id = snapshot.data[0]['idmitra'].toString();  
             passingIdMitra = snapshot.data[0]['username'].toString();  
           
            
          }
          return snapshot.hasData
              ?  
              Container(
                  padding: EdgeInsets.all(25.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'Data anda telah kami terima dan akan kami proses segera'),
                      Text(
                          'Silahkan gunakan ID ini ketika akan login berikutnya di Aplikasi'),
                      Text(
                        '${snapshot.data[0]["username"]}',
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),

                      Text('Proteksi akun Anda dengan password'),
                      // TextField(
                      //     controller: passwordController,
                      //     autofocus: true,
                      //     decoration: InputDecoration(
                      //       labelText: 'Password Baru',
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(
                      //         color: Colors.green,
                      //       )),
                      // )),
                      //  FlatButton.icon(
                      //           color: Colors.lightBlue,
                      //           splashColor: Colors.red,
                      //           label: Text(
                      //             'Set Password',
                      //             style: TextStyle(color: Colors.white,
                      //               fontWeight: FontWeight.bold),
                      //           ),
                      //           icon: Icon(
                      //             Icons.lock,
                      //             color: Colors.white,
                      //           ),
                      //           onPressed: () {

                      //             //Navigator.pop(context);
                      //           },
                      //         ),
                      new Expanded(
                        child: new Form(
                          key: _formKey,
                          child: new ListView(
                            children: <Widget>[
                              TextFormField(
                                validator: (input) => input.length == 0
                                    ? 'Form Password harus diisi !'
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
                                  labelText: 'Password Baru',
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
                                  'Set Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _setPasswordMitra();
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
              : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Data Sedang diproses....',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      CircularProgressIndicator(),
                    ],
                  );
        },
      ),
    );
  }
}
