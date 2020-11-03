import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:path_provider/path_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime backbuttonpressedTime;
  var val;
  var lx = 0;
  var kunci;

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

  _write(String text, files) async {
//   final password = "user_provided_password";
// final String salt = await cryptor.generateSalt();
// final String key = await cryptor.generateKeyFromPassword(password, salt);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$files');
    await file.writeAsString(text);
    // print("finish");
    // await baca();
  }

  void _showDialog(judul, konten) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(judul),
          content: new Text(konten),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.green[400]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

  cekakun() async {
    var email = mail.text;
    var role;
    var uname;
    var pass = pwd.text;
    print(email);
    print(pass);
    if (email == '' || pass == '') {
      _showDialog("Warning", "email or password can't be empty");
      setState(() {
        lx = 0;
      });
    } else if (email != "" && pass != "") {
      setState(() {
        lx = 1;
      });
      var id;
      id = await Firestore.instance
          .collection('akun')
          .getDocuments()
          .then((value) => id = value.documents);
      // print(id.length);
      // print(id[0]['pass']);
      // id
      // print("object");
      jumlahuser.add(id.length);

      for (var i = 0; i < id.length; i++) {
        print(id[i]['email']);
        if (id[i]['email'] == email && id[i]['pass'] == pass) {
          // print("masukkk");
          role = id[i]['role'];
          uname = id[i]['username'];
          var url = id[i]['foto'];
          url == "" ? url = "placeholder-profile-sq.jpg" : url = url;
          // print("sssssssss");
          FirebaseStorage storage = new FirebaseStorage(
              storageBucket: 'gs://autohydro-a90c1.appspot.com/');
          StorageReference imageLink = storage.ref().child(url);
          var link = await imageLink.getDownloadURL();
//  print(link);
          //  await _write('$email' + ',$pass');
          //  print(token);
          profil.add(Profiledata(uname.toString(), link, role, url));
          await _write('$email', 'token.txt');
          await _write('$pass', 'tokenz.txt');
          //  print(token);
          print('$role' + ' $uname');
        }
      }
      // print(role);
      if (role != null && uname != null) {
        getData();
      } else if (role == null || uname == null) {
        _showDialog("Failed", "email or password are wrong");
        setState(() {
          lx = 0;
        });
      }
    }
  }

  getfruit() async {
    // ceks.add(1);
    datareport.clear();
    var val;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    // print(val.length);
    if (val.length == 0) {
      // print("belum ada buah");
    } else if (val.length != 0) {
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
              print('$difference' + 'day');
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
              // print(val[i]['buah']);
              foto.add(datab[y].image);
              color.add(datab[y].colorval);
              var tgl = DateTime(date.year, date.month, date.day);
              var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
              final difference = tgl2.difference(tgl).inDays;
              // print('$difference' + 'day');
              jumlahdata.add(difference);
              // print(date2);
              datareport.add(
                  Report(val[i]['buah'], date.toString(), date2.toString()));
            }
          }
          // var tgl = DateFormat('y-e-d ').format(date2);

        }
      }
    }
  }

  getData() async {
    var fal;
    await getfruit();
    await getsetpoint();
    await Firestore.instance
        .collection('tanaman')
        .orderBy('tanggal tanam', descending: true)
        .getDocuments()
        .then((value) => fal = value.documents);
    //  print(val);
    //  .getDocuments().then((value) =>  val = value.documents);
    //  var data = val.length;
    //  print(data);
    //  print(val[0]['buah']);
    if (fal.length != 0) {
      for (var y = 0; y < datab.length; y++) {
        if (fal[0]['buah'] == datab[y].buah) {
          // print("2222222");
          tampilan.add(Buah1(datab[y].buah, datab[y].image, datab[y].latin,
              datab[y].colorval));
        }
      }
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => Bottom()));
  }

  TextEditingController mail = new TextEditingController();
  TextEditingController pwd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      child: Scaffold(
          // resizeToAvoidBottomInset: true,
          body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                        controller: mail,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "your@email.com")),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      controller: pwd,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Password"),
                      obscureText: true,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    cekakun();
                    // getData();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(125, 209, 151, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: lx == 1
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(57, 96, 69, 1)),
                              )
                            : Text(
                                "Log in",
                                style: TextStyle(
                                    color: Color.fromRGBO(57, 96, 69, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    fontWeight: FontWeight.w700),
                              )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // Padding(
              //   padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //           "Belum Punya Akun ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              //           SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.05,
              // ),
              //       // InkWell(
              //       //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));},
              //       //   child: Text(
              //       //     "Daftar",
              //       //     style: TextStyle(
              //       //         color: Color.fromRGBO(125, 209, 151, 1),
              //       //         fontSize: MediaQuery.of(context).size.width * 0.045,
              //       //         fontWeight: FontWeight.w700),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // )
            ],
          ),
        ],
      )),
      onWillPop: onWillPop,
    );
  }
}
