import 'dart:async';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:hydroponic/primarypage/subpage/customsp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/detailplant.dart';
import 'package:hydroponic/primarypage/subpage/editsp.dart';
import 'package:hydroponic/primarypage/subpage/editspupdate.dart';
import 'package:hydroponic/primarypage/subpage/notes.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  // method() => createState().lala();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
//   var recentJobsRef =   FirebaseDatabase.instance
// .reference().child("hidroponik-bcd58/monitoring/-MCnDk-Rn8Bn6fzOYEhv").orderByChild('sensor');
// var sp =
// var data;
  var initial = 1;
  var sp1 = "_", sp2 = "_", sp3 = "_";
  var val;
  var t = "...";

// lala(){
//   sp1 ="90";
//   setState(() {

//   });
// }
  var jenis;
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
  getdata() async {
    var time = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
      currindex = 1;

      setState(() {});

      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Bottom()));
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
      jenis == "lampu"
          ? databar1.add(Stacked(tgl.toString(), datas[i]['lampu'],
              Color.fromRGBO(96, 168, 90, 1)))
          : jenis == "air"
              ? databar2.add(Stacked(tgl.toString(), datas[i]['tinggi air'],
                  Color.fromRGBO(130, 255, 119, 1)))
              : jenis == "nutrisi"
                  ? databar3.add(Stacked(tgl.toString(), datas[i]['nutrisi'],
                      Color.fromRGBO(52, 104, 67, 1)))
                  : jenis == "ph"
                      ? databar4.add(Stacked(tgl.toString(), datas[i]['ph'],
                          Color.fromRGBO(135, 173, 70, 0.62)))
                      : print("");
    }
    currindex = 1;
    setState(() {});

    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => Bottom()));
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

  get_fruitandspname_latest() async {
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    for (var i = 0; i < val.length; i++) {
      if (val[i]['tanggal panen'] == "") {
        var jsp = val[i]['jsp'];
        jsp == 1 ? titles = val[i]['SP'] : titles = val[i]['sp' + "$jsp"];
        buahedit = val[i]['buah'];
      }
    }
  }

  gettime() {
    var tgl = DateTime.now();
    var tgl2 = DateFormat('EEE , d LLL y').format(tgl);
    // var tgl3 = DateFormat('d LLL y').format(tgl);
    setState(() {
      t = tgl2;
      // ts = tgl3;
    });
  }

  getSetpoint() async {
    await Firestore.instance
        .collection('Setpoint')
        .getDocuments()
        .then((value) => val = value.documents);
    data.clear();
    data.add(Setp(val[0]['nutrisi']));
    data.add(Setp(val[0]['ph']));
    data.add(Setp(val[0]['lampu']));
    sp2 = data[0].value;
    sp1 = data[1].value;
    sp3 = data[2].value;
    // print("ok");
    setState(() {
      // sp2 ="ola";
    });
    if (setp[0].value != data[0].value ||
        setp[1].value != data[1].value ||
        setp[2].value != data[2].value) {
      setp.clear();
      setp.addAll(data);

      setState(() {
        // sp2 ="ola";
      });
    }
  }

  matching() {
    if (tampilan[0].buah == "Strawberry") {
      tampilsp.addAll(strawberry);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Tomato") {
      tampilsp.addAll(tomato);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Orange") {
      tampilsp.addAll(orange);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Apple") {
      tampilsp.addAll(apple);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Egg Plant") {
      tampilsp.addAll(eggplant);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Blueberry") {
      tampilsp.addAll(blueberry);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Mango") {
      tampilsp.addAll(mango);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Watermelon") {
      tampilsp.addAll(watermelon);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Green Chili") {
      tampilsp.addAll(greenchili);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval, tampilan[0].deskripsi));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    }
  }

  random() {
    int min = 0;
    int max = 8;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);
    print(rNum);
  }

  getsetpoint() async {
    var datasp;
    // foto.clear();
    strawberry.clear();
    tomato.clear();
    watermelon.clear();
    orange.clear();
    blueberry.clear();
    mango.clear();
    apple.clear();
    eggplant.clear();
    greenchili.clear();
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
  }

  @override
  void initState() {
    // print(tampilan.length);
    gettime();
    getSetpoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    top: MediaQuery.of(context).size.width * 0.12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Good Morning!",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 82, 82, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07,
                      top: MediaQuery.of(context).size.width * 0.005),
                  child: Text(
                    t,
                    // "User",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(183, 183, 183, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.0380),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.7,
                top: MediaQuery.of(context).size.width * 0.1),
            child: CachedNetworkImage(
              imageUrl: profil[0].urlfoto,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              // placeholder: (context, url) => Container(
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: DecorationImage(
              //           image:
              //               AssetImage("assets/placeholder-profile-sq.jpg"))),
              // ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.085,
                top: MediaQuery.of(context).size.width * 0.38),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.83,
              height: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black12,
                        spreadRadius: 5.0,
                        offset: Offset(0, 8))
                  ]),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    left: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 1.05,
                    top: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 1.1,
                    child: tampilan.length == 0
                        ? Text("")
                        : SvgPicture.asset(
                            tampilan[0].image,
                            height: MediaQuery.of(context).size.width * 0.26,
                          ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: tampilan.length == 0
                        ? Text("")
                        : SvgPicture.asset(
                            "assets/Rectangle 46.svg",
                            height: MediaQuery.of(context).size.width * 0.26,
                            color: tampilan[0].colorval,
                          ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.054,
                            left: MediaQuery.of(context).size.width * 0.22),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: tampilan.length == 0
                              ? Text("")
                              : Text(
                                  tampilan[0].buah,
                                  style: TextStyle(
                                      color: tampilan.length == 0
                                          ? Colors.white
                                          : tampilan[0].colorval,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.048,
                                      fontWeight: FontWeight.w900),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.0,
                            left: MediaQuery.of(context).size.width * 0.22),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: tampilan.length == 0
                              ? Text("")
                              : Text(
                                  tampilan[0].latin,
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.038,
                                      fontWeight: FontWeight.w300),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.18,
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Did you know?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.042,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.033,
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.08,
                            child: Text(
                              tampilan[0].deskripsi + "...",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Color.fromRGBO(176, 176, 176, 1),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.034,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.08),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              tampilsp.clear();
                              sp.clear();
                              matching();
                            },
                            child: Text(
                              "Learn more",
                              style: TextStyle(
                                  color: tampilan[0].colorval,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.036,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.95,
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Text(
                    "Sensors Current Condition",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.0,
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Text(
                    "check the current condition of all sensors",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: MediaQuery.of(context).size.width * 0.034,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.width * 0.04),
                child: StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .reference()
                        .child("/Sensor")
                        .orderByChild('Realtime')
                        .onValue,
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      jenis = "lampu";
                                    });
                                    getdata();
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.205,
                                    width: MediaQuery.of(context).size.width *
                                        0.205,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 20,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055),
                                      child: Column(
                                        children: <Widget>[
                                          // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                          Column(
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    "assets/lamp.svg",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.015),
                                                child: Row(
                                                  children: <Widget>[
                                                    // DataSnapshot snapshot = snap.data.snapshot;
                                                    // if(!snap.hasData)return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),);
                                                    // DataSnapshot snapshot = snap.data.snapshot;
                                                    // // print(snapshot.value['sensor']);
                                                    // var string = snapshot.value['sensor'];
                                                    // var val = string.split('#');
                                                    // data.add(val);
                                                    // print(val);

                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            top:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.0),
                                                        child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            child:
                                                                CircularProgressIndicator())),

                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                      child: Text(
                                                        "/",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03,
                                                            color:
                                                                Color.fromRGBO(
                                                                    185,
                                                                    185,
                                                                    185,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                      child: Text(
                                                        sp1,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03,
                                                            color:
                                                                Color.fromRGBO(
                                                                    69,
                                                                    180,
                                                                    215,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        jenis = "ph";
                                      });
                                      getdata();
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.205,
                                      width: MediaQuery.of(context).size.width *
                                          0.205,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[300],
                                                blurRadius: 20,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055),
                                        child: Column(
                                          children: <Widget>[
                                            // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                            Stack(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  "assets/ph (2).svg",
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.077,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.077,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          child:
                                                              CircularProgressIndicator())),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                    child: Text(
                                                      "/",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                          color: Color.fromRGBO(
                                                              185, 185, 185, 1),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                    child: Text(
                                                      sp2,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                          color: Color.fromRGBO(
                                                              69, 180, 215, 1),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        jenis = "air";
                                      });
                                      getdata();
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.205,
                                      width: MediaQuery.of(context).size.width *
                                          0.205,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[300],
                                                blurRadius: 20,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055),
                                        child: Column(
                                          children: <Widget>[
                                            // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                            Stack(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  "assets/flood.svg",
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.077,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.077,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          child:
                                                              CircularProgressIndicator())),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        jenis = "nutrisi";
                                      });
                                      getdata();
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.205,
                                      width: MediaQuery.of(context).size.width *
                                          0.205,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[300],
                                                blurRadius: 20,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055),
                                        child: Column(
                                          children: <Widget>[
                                            // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                            Stack(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  "assets/fertilizer.svg",
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.09,
                                                      ),
                                                      child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          child:
                                                              CircularProgressIndicator())),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      DataSnapshot snapshot = snap.data.snapshot;
                      // print(snapshot.value['sensor']);
                      var string = snapshot.value['Realtime'];
                      var val = string.split('#');
                      // data.add(val);
                      getSetpoint();
                      // print(val);
                      // val == initial ? print("yes") : print('no');
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    jenis = "lampu";
                                  });
                                  getdata();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.205,
                                  width:
                                      MediaQuery.of(context).size.width * 0.205,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 20,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            0.055),
                                    child: Column(
                                      children: <Widget>[
                                        // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                        Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  "assets/lamp.svg",
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  // DataSnapshot snapshot = snap.data.snapshot;
                                                  // if(!snap.hasData)return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),);
                                                  // DataSnapshot snapshot = snap.data.snapshot;
                                                  // // print(snapshot.value['sensor']);
                                                  // var string = snapshot.value['sensor'];
                                                  // var val = string.split('#');
                                                  // data.add(val);
                                                  // print(val);

                                                  Text(
                                                    val[1].toString(),
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Color.fromRGBO(
                                                            104, 223, 85, 1),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                    child: Text(
                                                      "/",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                          color: Color.fromRGBO(
                                                              185, 185, 185, 1),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                    child: Text(
                                                      sp3,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                          color: Color.fromRGBO(
                                                              69, 180, 215, 1),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      jenis = "ph";
                                    });
                                    getdata();
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.205,
                                    width: MediaQuery.of(context).size.width *
                                        0.205,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 20,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055),
                                      child: Column(
                                        children: <Widget>[
                                          // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                          Stack(
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                "assets/ph (2).svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.077,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.077,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  val[4].toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      color: Color.fromRGBO(
                                                          104, 223, 85, 1),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                  child: Text(
                                                    "/",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Color.fromRGBO(
                                                            185, 185, 185, 1),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                  child: Text(
                                                    sp1,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Color.fromRGBO(
                                                            69, 180, 215, 1),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      jenis = "air";
                                    });
                                    getdata();
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.205,
                                    width: MediaQuery.of(context).size.width *
                                        0.205,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 20,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055),
                                      child: Column(
                                        children: <Widget>[
                                          // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                          Stack(
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                "assets/flood.svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.077,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.077,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  val[3].toString() + ' cm',
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      color: Color.fromRGBO(
                                                          104, 223, 85, 1),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      jenis = "nutrisi";
                                    });
                                    getdata();
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.205,
                                    width: MediaQuery.of(context).size.width *
                                        0.205,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 20,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055),
                                      child: Column(
                                        children: <Widget>[
                                          // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                          Stack(
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                "assets/fertilizer.svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  val[2].toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      color: Color.fromRGBO(
                                                          104, 223, 85, 1),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                  child: Text(
                                                    "/",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Color.fromRGBO(
                                                            185, 185, 185, 1),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                  child: Text(
                                                    sp2,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        color: Color.fromRGBO(
                                                            69, 180, 215, 1),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.4),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.95,
                        left: MediaQuery.of(context).size.width * 0.08),
                    child: Text(
                      "Custom Setting Point",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.0,
                            left: MediaQuery.of(context).size.width * 0.08),
                        child: Text(
                          "You can update setting point here",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => Settingpoint()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Color.fromRGBO(96, 168, 90, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        lampug = sp3;
                        nutrisig = sp2;
                        phg = sp1;
                        // titles = "spname";
                        // buahedit = "buah";
                        await get_fruitandspname_latest();
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => Editupdate()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: Color.fromRGBO(96, 168, 90, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04,
                      left: MediaQuery.of(context).size.width * 0.07),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.205,
                            width: MediaQuery.of(context).size.width * 0.205,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 20,
                                      offset: Offset(0, 3))
                                ]),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width *
                                      0.055),
                              child: Column(
                                children: <Widget>[
                                  // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                  Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          SvgPicture.asset("assets/lamp.svg",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            // DataSnapshot snapshot = snap.data.snapshot;
                                            // if(!snap.hasData)return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),);
                                            // DataSnapshot snapshot = snap.data.snapshot;
                                            // // print(snapshot.value['sensor']);
                                            // var string = snapshot.value['sensor'];
                                            // var val = string.split('#');
                                            // data.add(val);
                                            // print(val);

                                            Text(
                                              sp3,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                  color: Color.fromRGBO(
                                                      69, 180, 215, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.205,
                              width: MediaQuery.of(context).size.width * 0.205,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 20,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.055),
                                child: Column(
                                  children: <Widget>[
                                    // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                    Stack(
                                      children: <Widget>[
                                        SvgPicture.asset("assets/ph (2).svg",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.075,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.075),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            sp1,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                color: Color.fromRGBO(
                                                    69, 180, 215, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.205,
                              width: MediaQuery.of(context).size.width * 0.205,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 20,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.055),
                                child: Column(
                                  children: <Widget>[
                                    // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                    Stack(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            "assets/fertilizer.svg",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.075,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.075),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              sp2,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                  color: Color.fromRGBO(
                                                      69, 180, 215, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08),
                    child: Text(
                      "Add Notes For Today",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.08),
                        child: Text(
                          "You can only add one notes for today here",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => Addnotes()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.12),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Color.fromRGBO(96, 168, 90, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
