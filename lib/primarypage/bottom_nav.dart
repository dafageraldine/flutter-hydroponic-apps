import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/primarypage/history.dart';
import 'package:hydroponic/primarypage/plant.dart';
import 'package:hydroponic/primarypage/profile.dart';
import 'package:intl/intl.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  var datas;
  var segmen;
  var at;
  var loop1;
  var loop2;
  var loop3;
  var loop4;
  var loop5;
  var loop6;
  var loop7;
  var loop8;
  getdata(time) async {
    DateTime start = DateTime.parse(time + ' 00:00');
    DateTime end = DateTime.parse(time + ' 23:59');
    // print(start);
    // print(notes[0]['tanggal dan waktu']);
    // Timestamp timestamp = notes[0]['tanggal dan waktu'];
    // var date = DateTime.parse(timestamp.toDate().toString());
    //   print('$date' + 'ini');
    // if (time.toString() == notes[0]['tanggal dan waktu'].toString())
    // print("sama");

    //  print(todayDate);
    //  print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    await Firestore.instance
        .collection("Sensor")
        .where("tanggal dan waktu",
            isGreaterThanOrEqualTo: start, isLessThan: end)
        .getDocuments()
        .then((value) => datas = value.documents);
    if (datas.length == 0) {
      databar1.clear();
      databar2.clear();
      databar3.clear();
      databar4.clear();
      setState(() {});
      // _showDialog("Information", "Belum ada data");
    } else if (datas.length != 0) {
      print(datas);
      segment(datas.length);
    }
    // var time = timeago.format(waktu);
    // Timestamp timestamp = datas;
    // if (datas.length > 7 ){
    // var math = (10 / 5  ).floor();
//  var date = DateTime.parse(timestamp.toDate().toString());
    // var date = new DateTime.fromMillisecondsSinceEpoch(waktu * 1000);
    // print(formatDate(date, ['HH',':','nn'],));
    // print(timeago.format(DateTime.tryParse(timestamp.toDate().toString())));//jika mau mendapatkan log
  }

  tampildata(awal, iter) {
    databar1.clear();
    databar2.clear();
    databar3.clear();
    databar4.clear();
    for (var i = awal; i < iter; i++) {
      Timestamp timestamp = datas[i]['tanggal dan waktu'];
      var date = DateTime.parse(timestamp.toDate().toString());
      var tgl = formatDate(
        date,
        ['HH', ':', 'nn'],
      );
      databar1.add(Stacked(
          tgl.toString(), datas[i]['lampu'], Color.fromRGBO(96, 168, 90, 1)));
      databar2.add(Stacked(tgl.toString(), datas[i]['tinggi air'],
          Color.fromRGBO(130, 255, 119, 1)));
      databar3.add(Stacked(
          tgl.toString(), datas[i]['nutrisi'], Color.fromRGBO(52, 104, 67, 1)));
      databar4.add(Stacked(
          tgl.toString(), datas[i]['ph'], Color.fromRGBO(135, 173, 70, 0.62)));
    }
    setState(() {});
  }

  segment(length) {
    // var length;
    if (length < 8) {
      tampildata(0, length);
      segmen = 1;
      at = 1;
      print("$length" + " hasil " + '$length');
    } else {
      segmen = int.parse((length / 5).toStringAsFixed(0));
      loop1 = int.parse((length / segmen).toStringAsFixed(0));
      loop2 = length - loop1;
      loop3 = int.parse((loop2 / (loop2 / loop1)).toStringAsFixed(0));
      if (loop2 < 7) {
        at = 1;
        segmen = 2;
        tampildata(0, loop1);
        print("$length" + " hasil " + '$loop1' + ' $loop2');
      } else if (loop2 > 7) {
        loop4 = loop2 - loop3;
        loop5 = loop4 - (loop4 - loop3);
        loop6 = length - (loop1 + loop3 + loop5);
        if (loop4 < 7) {
          at = 1;
          segmen = 3;
          tampildata(0, loop1);
          print("$length" + " hasil " + "$loop1" + ' $loop3' + ' $loop4');
        } else if (loop4 > 7) {
          if (loop6 < 7) {
            at = 1;
            segmen = 4;
            tampildata(0, loop1);
            print("$length" +
                " hasil " +
                "$loop1" +
                ' $loop3' +
                ' $loop5' +
                ' $loop6');
          } else if (loop6 > 7) {
            loop7 = loop6 - (loop6 - loop5);
            loop8 = loop6 - loop7;
            at = 1;
            segmen = 5;
            tampildata(0, loop1);
            print("$length" +
                " hasil " +
                "$loop1" +
                ' $loop3' +
                ' $loop5' +
                ' $loop7' +
                ' $loop8');
          }
        }
      }
    }
  }

  getactivity() async {
    var val;
    // try {
    await Firestore.instance
        .collection('activity')
        // .where("by", isEqualTo: profil[0].email)
        .orderBy("tanggal", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);

    aktifitas.clear();
    if (val.isNotEmpty) {
      // val.length > 1
      //     ? await Firestore.instance
      //         .collection('activity')
      //         .orderBy("tanggal", descending: true)
      //         .where("by", isEqualTo: profil[0].email,)
      //         .getDocuments()
      //         .then((value) => val = value.documents)
      //     : print("");
      for (var i = 0; i < val.length; i++) {
        if (val[i]['by'] == profil[0].email) {
          Timestamp timestamp = val[i]['tanggal'];
          var date = DateTime.parse(timestamp.toDate().toString());
          aktifitas.add(Aktifitas(val[i]['jenis'], val[i]['pesan'], date));
        }
      }
    }
    print(aktifitas.length);
  }

  getsetpoint() async {
    strawberry.clear();
    tomato.clear();
    watermelon.clear();
    orange.clear();
    blueberry.clear();
    mango.clear();
    apple.clear();
    eggplant.clear();
    greenchili.clear();
    var datasp;
    await Firestore.instance
        .collection('setpoint-collection')
        .getDocuments()
        .then((value) => datasp = value.documents);

    for (var i = 0; i < datasp.length; i++) {
      if (datasp[i]['buah'] == "Strawberry") {
        var vals = datasp[i]['value'].split('#');
        strawberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Tomato") {
        var vals = datasp[i]['value'].split('#');
        tomato.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Orange") {
        var vals = datasp[i]['value'].split('#');
        orange.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Apple") {
        var vals = datasp[i]['value'].split('#');
        apple.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Egg Plant") {
        var vals = datasp[i]['value'].split('#');
        eggplant.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Blueberry") {
        var vals = datasp[i]['value'].split('#');
        blueberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Mango") {
        var vals = datasp[i]['value'].split('#');
        mango.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Watermelon") {
        var vals = datasp[i]['value'].split('#');
        watermelon.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Green Chili") {
        var vals = datasp[i]['value'].split('#');
        greenchili.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      }
    }
    // print("finish");
  }

  int _currentIndex = 0;
  DateTime backbuttonpressedTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    exit(0);
    return true;
  }

  List<Widget> tabs = <Widget>[Dashboard(), History(), Plant(), Profile()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // body: tabs[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: currindex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/Rectangle.svg",
                ),
                activeIcon: SvgPicture.asset(
                  "assets/Group 64.svg",
                ),
                title: Text("Home"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/Vector 21.svg"),
                activeIcon: SvgPicture.asset(
                  "assets/Group 49.svg",
                ),
                title: Text("History"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/plant icon.svg"),
                activeIcon: SvgPicture.asset(
                  "assets/Group 104.svg",
                ),
                title: Text("Plant"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/user icon.svg"),
                activeIcon: SvgPicture.asset("assets/Group 105.svg",
                    color: Color.fromRGBO(111, 229, 123, 1)),
                title: Text("Profile"),
                backgroundColor: Colors.white),
          ],
          onTap: (index) async {
            if (index == 2) {
              await getsetpoint();
            } else if (index == 3) {
              await getactivity();
            } else if (index == 1) {
              var ctime = DateFormat('yyyy-MM-dd').format(DateTime.now());
              getdata(ctime);
            }
            setState(() {
              currindex = index;
              // print(index);
            });
          },
        ),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
      ),
      onWillPop: onWillPop,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [Dashboard(), History(), Plant(), Profile()].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: currindex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
