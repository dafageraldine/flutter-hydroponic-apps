import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:hydroponic/primarypage/login.dart';
import 'package:path_provider/path_provider.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  DateTime backbuttonpressedTime;
  var val;
  run() async {
    // for(var i=0;i <1000;i++){
    var pass = await read("tokenz.txt");
    var email = await read('token.txt');
    // print(token);
    if (pass == "no teks") {
      Timer(const Duration(seconds: 4), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else if (pass != "no teks" || pass != "") {
      //  var data = token.split(',');
      //  var email = data[0];
      //  var pass = data[1];
      //  print(mail+pass);
      var id;
      id = await Firestore.instance
          .collection('akun')
          .getDocuments()
          .then((value) => id = value.documents);
      jumlahuser.add(id.length);
      // print(id.length);
      // print(id[0]['email']);
      var role;
      var uname;

      for (var i = 0; i < id.length; i++) {
        if (id[i]['email'] == email && id[i]['pass'] == pass) {
          role = id[i]['role'];
          uname = id[i]['username'];
          var url = id[i]['foto'];
          url == "" ? url = "placeholder-profile-sq.jpg" : url = url;

          FirebaseStorage storage = new FirebaseStorage(
              storageBucket: 'gs://autohydro-a90c1.appspot.com/');
          StorageReference imageLink = storage.ref().child(url);
          var link = await imageLink.getDownloadURL();
          //  await _write('$email' + ',$pass');
          //  print(token);
          print('$role' + ' $uname');
          getData();
          profil.add(
              Profiledata(uname.toString(), link, role, url, id[i]['email']));
        }
      }
      if (role == null || uname == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottom()));
    }
    // }
    // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>Login()));
  }

  Future<String> read(files) async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$files');
      text = await file.readAsString();
    } catch (e) {
      return "no teks";
    }
    // print(text);
    return text;
  }

  getfruit() async {
    // ceks.add(1);
    jumlahdata.clear();
    datareport.clear();
    foto.clear();
    color.clear();
    var val;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    print(val.length);
    if (val.length == 0)
      print("belum ada buah");
    else if (val.length != 0) {
      for (var i = 0; i < val.length; i++) {
        if (val[i]['tanggal panen'] != "") {
          Timestamp timestamp = val[i]['tanggal tanam'];
          var date = DateTime.parse(timestamp.toDate().toString());
          Timestamp timestamps = val[i]['tanggal panen'];
          var date2 = DateTime.parse(timestamps.toDate().toString());
          for (var y = 0; y < datab.length; y++) {
            if (val[i]['buah'] == datab[y].buah) {
              // ceks.add(i);
              // print(val[i]['buah']);
              foto.add(datab[y].image);
              color.add(datab[y].colorval);
              var tgl = DateTime(date.year, date.month, date.day);
              var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
              final difference = tgl2.difference(tgl).inDays;
              // print('$difference' + 'day');
              jumlahdata.add(difference);
              datareport.add(
                  Report(val[i]['buah'], date.toString(), date2.toString()));
            }
          }
          for (var k = 0; k < customlog.length; k++) {
            if (val[i]['buah'] == customlog[k].nama) {
              foto.add("assets/customplant.svg");
              color.add(Colors.green[200]);
              var tgl = DateTime(date.year, date.month, date.day);
              var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
              final difference = tgl2.difference(tgl).inDays;
              // print('$difference' + 'day');
              jumlahdata.add(difference);
              datareport.add(
                  Report(val[i]['buah'], date.toString(), date2.toString()));
            }
          }
        } else if (val[i]['tanggal panen'] == "") {
          Timestamp timestamp = val[i]['tanggal tanam'];
          var date = DateTime.parse(timestamp.toDate().toString());
          // Timestamp timestamps = val[i]['tanggal panen'];
          var date2 = DateTime.now();
          for (var y = 0; y < datab.length; y++) {
            if (val[i]['buah'] == datab[y].buah) {
              print(val[i]['buah']);
              foto.add(datab[y].image);
              color.add(datab[y].colorval);
              var tgl = DateTime(date.year, date.month, date.day);
              var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
              final difference = tgl2.difference(tgl).inDays;
              print('$difference' + 'day');
              jumlahdata.add(difference);
              // print(date2);
              datareport.add(
                  Report(val[i]['buah'], date.toString(), date2.toString()));
            }
          }
          for (var k = 0; k < customlog.length; k++) {
            if (val[i]['buah'] == customlog[k].nama) {
              foto.add("assets/customplant.svg");
              color.add(Colors.green[200]);
              var tgl = DateTime(date.year, date.month, date.day);
              var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
              final difference = tgl2.difference(tgl).inDays;
              // print('$difference' + 'day');
              jumlahdata.add(difference);
              datareport.add(
                  Report(val[i]['buah'], date.toString(), date2.toString()));
            }
          }
          // var tgl = DateFormat('y-e-d ').format(date2);

        }
      }
    }
  }

  // getfruity() async {
  //   // ceks.add(1);
  //   datareport.clear();
  //   var val;
  //   await Firestore.instance
  //       .collection('tanaman')
  //       .orderBy("tanggal tanam", descending: true)
  //       .getDocuments()
  //       .then((value) => val = value.documents);
  //   // print(val.length);
  //   if (val.length == 0)
  //     print("belum ada buah");
  //   else if (val.length != 0) {
  //     for (var i = 0; i < val.length; i++) {
  //       if (val[i]['tanggal panen'] != "") {
  //         Timestamp timestamp = val[i]['tanggal tanam'];
  //         var date = DateTime.parse(timestamp.toDate().toString());
  //         Timestamp timestamps = val[i]['tanggal panen'];
  //         var date2 = DateTime.parse(timestamps.toDate().toString());
  //         for (var y = 0; y < datab.length; y++) {
  //           if (val[i]['buah'] == datab[y].buah) {
  //             // ceks.add(i);
  //             // print(val[i]['buah']);
  //             foto.add(datab[y].image);
  //             color.add(datab[y].colorval);
  //             var tgl = DateTime(date.year, date.month, date.day);
  //             var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
  //             final difference = tgl2.difference(tgl).inDays;
  //             print('$difference' + 'day');
  //             jumlahdata.add(difference);

  //             datareport.add(
  //                 Report(val[i]['buah'], date.toString(), date2.toString()));
  //           }
  //         }
  //       } else if (val[i]['tanggal panen'] == "") {
  //         Timestamp timestamp = val[i]['tanggal tanam'];
  //         var date = DateTime.parse(timestamp.toDate().toString());
  //         // Timestamp timestamps = val[i]['tanggal panen'];
  //         var date2 = DateTime.now();
  //         for (var y = 0; y < datab.length; y++) {
  //           if (val[i]['buah'] == datab[y].buah) {
  //             // print(val[i]['buah']);
  //             foto.add(datab[y].image);
  //             color.add(datab[y].colorval);
  //             var tgl = DateTime(date.year, date.month, date.day);
  //             var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
  //             final difference = tgl2.difference(tgl).inDays;
  //             // print('$difference' + 'day');
  //             jumlahdata.add(difference);
  //             // print(date2);
  //             datareport.add(
  //                 Report(val[i]['buah'], date.toString(), date2.toString()));
  //           }
  //         }
  //         // var tgl = DateFormat('y-e-d ').format(date2);

  //       }
  //     }
  //   }
  // }

  getsetpoint() async {
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
  }

  getS() async {
    await Firestore.instance
        .collection('Setpoint')
        .getDocuments()
        .then((value) => val = value.documents);
    data.clear();
    data.add(Setp(val[0]['nutrisi']));
    data.add(Setp(val[0]['ph']));
    data.add(Setp(val[0]['lampu']));
    // dummy = data[0]['ph'];
    // sp3 = data[0]['lampu'];
    // sp2 = data[0].value;
    // sp1 = data[1].value;
    // sp3 = data[2].value;
    setp.addAll(data);

    setState(() {
      // sp2 ="ola";
    });
  }

  getcustomplant() async {
    var val;
    await Firestore.instance
        .collection('customplant')
        .getDocuments()
        .then((value) => val = value.documents);
    customlog.clear();
    custom.clear();
    // print(val[0]);
    if (val.isNotEmpty) {
      for (var i = 0; i < val.length; i++) {
        if (val[i]['status'] == "aktif") {
          custom.add(Customplant(
              val[i]['tanaman'], val[i]['latin'], val[i]['deskripsi']));
        }
        customlog.add(Customplant(
            val[i]['tanaman'], val[i]['latin'], val[i]['deskripsi']));
      }
    }
  }

  getData() async {
    await getcustomplant();
    await getfruit();
    await getsetpoint();
    await getS();
    // await Firestore.instance
    //     .collection('tanaman')
    //     .orderBy('tanggal tanam', descending: true)
    //     .getDocuments()
    //     .then((value) => val = value.documents);
    // //  print(val);
    // //  .getDocuments().then((value) =>  val = value.documents);
    // //  var data = val.length;
    // //  print(data);
    // // print(val[0]['buah']);
    // if (val.length != 0) {
    //   for (var y = 0; y < datab.length; y++) {
    //     if (val[0]['buah'] == datab[y].buah) {
    //       tampilan.add(Buah1(datab[y].buah, datab[y].image, datab[y].latin,
    //           datab[y].colorval));
    //     }
    //   }
    // }
    int min = 0;
    int max = 8;
    var randomizer = new Random();
    var y = min + randomizer.nextInt(max - min);
    tampilan.add(Buah1(datab[y].buah, datab[y].image, datab[y].latin,
        datab[y].colorval, datab[y].deskripsi));

    Navigator.push(context, MaterialPageRoute(builder: (context) => Bottom()));
  }

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

  @override
  void initState() {
    run();
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        // resizeToAvoidBottomPadding: false,
        body: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  "assets/Rectangle 56.svg",
                )),
            Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(
                  "assets/Rectangle 55.svg",
                )),
            Positioned(
                right: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 1.15,
                top: MediaQuery.of(context).size.height * 0.1,
                child: SvgPicture.asset("assets/watermelon.svg",
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5)),
            Positioned(
                left: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 1.15,
                top: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 1.02,
                child: SvgPicture.asset("assets/eggplant.svg",
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5)),
            Positioned(
                left: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 1.18,
                top: MediaQuery.of(context).size.height * 0.35,
                child: SvgPicture.asset("assets/tomato.svg",
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5)),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.25,
                bottom: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 1.1,
                child: SvgPicture.asset("assets/strawberry.svg",
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6)),
            Positioned(
                right: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 1.1,
                bottom: MediaQuery.of(context).size.height * 0.2,
                child: SvgPicture.asset("assets/healthy-food.svg",
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6)),
            Center(
                child: Text(
              "Plant",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: Color.fromRGBO(190, 233, 118, 1)),
            )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.09),
              child: Center(
                  child: Text("ROBO",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.grey[300]))),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(255, 255, 255, 0.2),
            )
          ],
        ),
      ),
    );
  }
}
