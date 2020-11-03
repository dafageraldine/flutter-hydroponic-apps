import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/primarypage/subpage/customsp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/detailplant.dart';
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
      Timer(const Duration(seconds: 1), () async {
        await getData();
      });
      setState(() {
        // sp2 ="ola";
      });
    }
  }

  matching() {
    if (tampilan[0].buah == "Strawberry") {
      tampilsp.addAll(strawberry);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Tomato") {
      tampilsp.addAll(tomato);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Orange") {
      tampilsp.addAll(orange);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Apple") {
      tampilsp.addAll(apple);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Egg Plant") {
      tampilsp.addAll(eggplant);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Blueberry") {
      tampilsp.addAll(blueberry);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Mango") {
      tampilsp.addAll(mango);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Watermelon") {
      tampilsp.addAll(watermelon);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    } else if (tampilan[0].buah == "Green Chili") {
      tampilsp.addAll(greenchili);
      sp.add(Buah(tampilan[0].buah, tampilan[0].image, tampilan[0].latin,
          tampilan[0].colorval));
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Detailplant()));
    }
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

  getData() async {
    var vals;
    // await getfruit();
    // await getsetpoint();
    // await getS();
    await Firestore.instance
        .collection('tanaman')
        .orderBy('tanggal tanam', descending: true)
        .getDocuments()
        .then((value) => vals = value.documents);
    //  print(val);
    //  .getDocuments().then((value) =>  val = value.documents);
    // var data = vals.length;
    // print(data);
    print(vals[0]['buah']);
    if (vals.length != 0) {
      for (var y = 0; y < datab.length; y++) {
        if (vals[0]['buah'] == datab[y].buah) {
          tampilan.clear();
          // print("ssssss");
          // ignore: unnecessary_statements
          // tampilan[0].buah == datab[y].buah;
          tampilan.add(Buah1(datab[y].buah, datab[y].image, datab[y].latin,
              datab[y].colorval));
          setState(() {});
        }
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
                          child: tampilan.length == 0
                              ? Text(
                                  "Pick a plant first",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.042,
                                      fontWeight: FontWeight.w700),
                                )
                              : Text(
                                  "Did you know?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.042,
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
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: tampilan.length == 0
                                ? Text(
                                    "go to Discover hydroponic-plants page first",
                                    style: TextStyle(
                                        color: Color.fromRGBO(176, 176, 176, 1),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0380,
                                        fontWeight: FontWeight.w300),
                                  )
                                : Text(
                                    tampilan[0].buah +
                                        " adalah buah yang sehat dan kaya akan vitamin yang baik untuk tubuh anda",
                                    style: TextStyle(
                                        color: Color.fromRGBO(176, 176, 176, 1),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0380,
                                        fontWeight: FontWeight.w300),
                                  )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.08),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: tampilan.length == 0
                              ? Text("")
                              : InkWell(
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
                                            MediaQuery.of(context).size.width *
                                                0.036,
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
                                Container(
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
                                                          left: MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          top: MediaQuery.of(
                                                                      context)
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
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
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
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
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
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
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
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
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
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
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
                              Container(
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
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                                child: Text(
                                                  "/",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                                child: Text(
                                                  sp1,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
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
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                                child: Text(
                                                  "/",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                                child: Text(
                                                  sp2,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                            left: MediaQuery.of(context).size.width * 0.2),
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
