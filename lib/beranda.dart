import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {

  final String usernameMitra;

  const Beranda({Key key, this.usernameMitra}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _value = false;

  void _onChanged(bool value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        actions: <Widget>[
          Switch(
            value: _value,
            onChanged: (bool value) {
              _onChanged(value);
            },
            activeColor: Colors.yellow,
          )
        ],
      ),
      body: Container(
        child: Card(
          child : Column(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Halo ${widget.usernameMitra}'),
                      subtitle: Text('Selamat datang di Mitra BakuBantu'),
                    )
                  ],
                ),
              ),
              //Text('Selamat Bergabung dengan Mitra BakuBantu'),
              //Text('${widget.usernameMitra}'),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                
                  children: <Widget>[
                    RaisedButton.icon(
                      icon: Icon(Icons.account_box),
                      label: Text('Account'),
                      onPressed: ()=> SnackBar(content: Text('Account'),)
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.access_alarm),
                      label: Text('Alarm'),
                      onPressed: ()=> Text('Alarm'),
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.exit_to_app),
                      label: Text('Keluar'),
                      onPressed:(){
                        Navigator.pushReplacementNamed(context, "/keluar");
                      },
                    ),
                        
                      
                    
                  ],
                ),
              
            ],
          ),
        ), 
      ),
    );
  }
}