import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Updatejasa extends StatefulWidget {
  final String id;
  final String username;

  const Updatejasa({Key key, this.id, this.username}) : super(key: key);

  @override
  _UpdatejasaState createState() => _UpdatejasaState();
}

class _UpdatejasaState extends State<Updatejasa> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List> getDataJasa;

  TextEditingController jasaController = new TextEditingController();

  String jasa = "";
  String kategori = "";
  String detail;
  var _jasaMitra = new List<String>();
  var _listkategori = new List<String>();
  List<DropdownMenuItem<String>> listCategory = [];
  List<String> _category = <String>['kesehatan', 'kecantikan', 'servis'];
  String _selected = null;
  bool tombolNext = false;

  @override
  void initState() {
    super.initState();
    //getDataJasa = getJasa();
  }

  void loadCategory() {
    listCategory = [];
    listCategory = _category
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();
  }

  saveJasa(String category, String name) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("jasa", name);
      prefs.setString("kategori", category);
      setState(() {
        jasa = prefs.getString("jasa");
        kategori = prefs.getString("kategori");
        _jasaMitra.add(jasa);
        print(_jasaMitra);
        _listkategori.add(kategori);
        jasaController.text = "";
        //  _selected = null;
      });
    }
  }

  // Future<List> getJasa() async {
  //   final response = await http.get(
  //       "https://pocky-fifties.000webhostapp.com/jasa.php?id=${widget.id}");
  //   if (response.statusCode == 200) {
  //     // If server returns an OK response, parse the JSON
  //     return json.decode(response.body);
  //   } else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load post');
  //   }
  // }

  void addJasa() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var url = "https://pocky-fifties.000webhostapp.com/entryJasa.php";
      http.post(url, body: {
        "username": widget.id,
        "kategori": _selected,
        "detail": _jasaMitra.toString()
      });

      //jasaController.text = "";
      _formKey.currentState.reset();
      _jasaMitra = [];
      _selected = null;

      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Jasa tersimpan')));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadCategory();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new FormField<String>(
                validator: (input) {
                  if (input == null) {
                    return "masih kosong";
                  }
                },
                onSaved: (val) {
                  _selected = val;
                },
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.archive),
                          labelText: 'Kategori'),
                      isEmpty: _selected == "",
                      child: new DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            items: _category.map((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            hint: new Text('Pilih Kategori'),
                            value: _selected,
                            isDense: true,
                            onChanged: (value) {
                              state.didChange(value);
                              setState(() {
                                //   _jasaMitra.add(value);
                                //   jasa = jasa + "$_jasaMitra";
                                _selected = value;
                              });
                            }),
                      ));
                },
              ),

              new TextFormField(
                validator: (input) =>
                    input.length == 0 ? 'Form Jasa harus diisi !' : null,
                onSaved: (val) => detail = val,
                controller: jasaController,
                // onFieldSubmitted: (value) {
                //   setState(() {
                //     _jasaMitra.add(value);
                //     jasa = jasa + "$_jasaMitra";
                //     jasaController.text = "";
                //   });
                // },
                decoration: InputDecoration(
                  labelText: 'Detail Jasa',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.green,
                  )),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // FlatButton.icon(
              //     color: Colors.lightBlue,
              //     splashColor: Colors.red,
              //     label: Text(
              //       'Simpan',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //     icon: Icon(
              //       Icons.archive,
              //       color: Colors.white,
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         _jasaMitra.add(jasaController.text);
              //         //jasa = jasa + "$_jasaMitra";
              //         addJasa();
              //         jasaController.text = "";
              //         // _selected = null;
              //       });
              //     }),
              FlatButton.icon(
                  color: Colors.lightBlue,
                  splashColor: Colors.red,
                  label: Text(
                    'simpan',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.archive,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    saveJasa(_selected, jasaController.text);
                  }),
              Flexible(
                  child: ListView.builder(
                itemCount: _jasaMitra.length,
                itemBuilder: (BuildContext context, int index) {
                  tombolNext = true;
                  return Card(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(_listkategori[index]),
                          Text(_jasaMitra[index]),
                          Icon(Icons.control_point)
                        ],
                      ),
                    ),
                  );
                },
              )),
              // Flexible(
              //   child: FutureBuilder(
              //     future: getJasa(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) Text('${snapshot.error}');
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //           itemCount: snapshot.data.length == null
              //               ? 0
              //               : snapshot.data.length,
              //           itemBuilder: (context, index) {
              //             tombolNext = true;
              //             return ListTile(
              //               title: Text('${snapshot.data[index]['kategori']}'),
              //               subtitle:
              //                   Text('${snapshot.data[index]['detailJasa']}'),
              //             );
              //           },
              //         );
              //       } else if (snapshot.hasError) {
              //         return Text("${snapshot.error}");
              //       }

              //       // By default, show a loading spinner
              //       return Text('Jasa yang Anda miliki belum ada');
              //     },
              //   ),
              // ),

              tombolNext == true
                  ? FlatButton.icon(
                      color: Colors.green,
                      splashColor: Colors.red,
                      label: Text(
                        'Lanjut',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/beranda");
                        setState(() {
                          passingIdMitra = widget.username;

                        });
                      })
                  : Text("")
            ],
          ),
        ),
      ),
    );
  }
}
