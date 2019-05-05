import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../content/contentMidBox.dart';
import '../component/headerContent.dart';
import 'package:flutternew/component/clipper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  int _current = 0;
  var data = [0.0, 5.0, 2.0, 4.0, 3.0, 8.0, 10.0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  Widget headerTop(){
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Haloo Apa Kabar ?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              Text(
                'Mulai sesuatu yang baik',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
            child: CircleAvatar(
              child: Text('C'),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white12,
            ),
            width: 50.0,
            height: 50.0,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget midBox(){
    return ClipPath(
      clipper: Clipper(),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> ContentMidBox())
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(43.5)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFDFDFD),
                Color(0xFFEBF6F7),
              ]
            ),
          ),
          height: 260,
          width: 330,
          padding: EdgeInsets.fromLTRB(35, 35, 20, 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Dashboard",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                      ),
                      Text("halo selamat beraktifitas",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 13
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Divider(height: 2,),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  headerContent(
                    'Content',
                    () => Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 50),
                          radius: 14,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black45,
                          radius: 14,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          radius: 14,
                          child: Text('+3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ), 
                    110.0,//nilai untuk width fungsi header content
                  ),

                  headerContent(
                    'TUGAS ANDA',
                    () {
                      return Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.orangeAccent,
                            child: Icon(Icons.content_paste, size: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                          ),
                          Text(
                            '666',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          
                          ),
                          Text(
                            'Tasks',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          
                        ],
                      );
                    },
                    110.0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  headerContent(
                    'GRAFIK',
                    () {
                      return Container(
                        height: 25,
                        width: 105,
                        child: Sparkline(
                          data: data,
                          lineWidth: 5.0,
                          lineGradient: new LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFFE5788C), Color(0xFFFFC195)],
                          ),
                          pointsMode: PointsMode.last,
                          pointSize: 10.0,
                          pointColor: Colors.amber,
                        ),
                      );
                    },
                    110.0,
                  ),
                  headerContent(
                    'Tanggal',
                    () {
                      return Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red[300],
                            child: Icon(
                              Icons.folder_open,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                          ),
                          Text(
                            'Mar 30, 2019',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10 ),
                          ),
                        ],
                      );
                    },
                    110.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progressBox(title, progress, iconName, boxColorStart, boxColorEnd) {
    return ClipPath(
      clipper: Clipper(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(43.5),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              boxColorStart,
              boxColorEnd,
            ],
          ),
        ),
        height: 120,
        width: 120,
        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20.0,
              left: 50.0,
              right: 0.0,
              child: Icon(
                iconName,
                size: 50,
                color: Color(0x77FFFFFF),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  progress.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget summary() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
            child: Text(
              'Task Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          Row(
            
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 40),),
              progressBox(
                'Complete',
                86,
                Icons.done_all,
                Color(0xFF3DC9D2),
                Color(0xFF1CB293),
                // Size(20, 20)
              ),
              progressBox(
                'On Progress',
                16,
                Icons.settings,
                Color(0xFFFFA464),
                Color(0xFFFD7B5B),
              ),
              // progressBox(
              //   'OverDue',
              //   0,
              //   Icons.report_problem,
              //   Color(0xFFFC888F),
              //   Color(0xFFE059A3),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    // Text(
                    //   'Lain Lain',
                    //   style: TextStyle(color: Colors.grey[800], fontSize: 16),
                      
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10),
                    // ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 40),),
                        Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '99%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Icon(
                            Icons.trending_up,
                            color: Color(0xFF1DB395),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              '0.6%',
                              style: TextStyle(
                                  color: Color(0xFF1DB395),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 40),),
                      progressBox(
                        'OverDue',
                          0,
                          Icons.report_problem,
                          Color(0xFFFC888F),
                          Color(0xFFE059A3),
                        ),
                      ],
                    ),
                    
                  ],
                ),
                // Container(
                //   height: 45,
                //   width: 150,
                //   child: Sparkline(
                //     data: data,
                //     lineWidth: 5.0,
                //     lineGradient: new LinearGradient(
                //       begin: Alignment.centerLeft,
                //       end: Alignment.centerRight,
                //       colors: [Color(0xFFE5788C), Color(0xFFFFC195)],
                //     ),
                //     pointsMode: PointsMode.last,
                //     pointSize: 10.0,
                //     pointColor: Colors.amber,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    List headerList = [0, 1, 2, 3];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0374BB),
                  Color(0xFF32A8B7),
                  Colors.teal,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                headerTop(),
                CarouselSlider(
                  height: 260,
                  autoPlay: true,
                  updateCallback: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: headerList.map((index) => midBox()).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: headerList.map(
                    (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color(0xFFCDEBEE)
                              : Color(0xFF64C7C8),
                        ),
                      );
                    },
                  ).toList(),
                ),
                summary(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(width: 2, color: Colors.grey[200]))),
        height: 68,
        child: TabBar(
          labelPadding: EdgeInsets.only(top: 4),
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Color(0xFFBEC6D0),
          labelColor: Color(0xFF1FB499),
          // unselectedLabelStyle: TextStyle(color: Color(0xFFBEC6D0)),
          controller: tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 32,
              ),
              child: Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Text('Home'),
              ),
            ),
            Tab(
                icon: Icon(Icons.query_builder),
                child: Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Text('Task'),
                )),
            Tab(
                icon: Icon(Icons.chat_bubble_outline),
                child: Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Text('Chat'),
                )),
            Tab(
                icon: Icon(Icons.apps),
                child: Container(
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  child: Text('Menu'),
                ))
          ],
        ),
      ),
    );
  }
}