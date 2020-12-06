import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:path_provider/path_provider.dart';

import '../login.dart';

class Profilesettings extends StatefulWidget {
  @override
  _ProfilesettingsState createState() => _ProfilesettingsState();
}

class _ProfilesettingsState extends State<Profilesettings> {
  var lx = 0;
  var change = 0;
  var changes = 0;
  var b = 0;
  TextEditingController nnpwd = new TextEditingController();
  TextEditingController npwd = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController name = new TextEditingController();

  void _showDialog(judul, konten) {
    // flutter defined function
    showDialog(
      barrierDismissible:
          konten == "Password has been changed, please re login" ? false : true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(judul),
          content: new Text(konten),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            konten == "Password has been changed, please re login"
                ? FlatButton(
                    child: new Text(
                      "Close",
                      style: TextStyle(color: Colors.green[400]),
                    ),
                    onPressed: () async {
                      await logout();
                    },
                  )
                : new FlatButton(
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

  logout() async {
    var file1 = await getfile("token.txt");
    file1.delete();
    var file2 = await getfile("tokenz.txt");
    file2.delete();
    profil.clear();
    strawberry.clear();
    tomato.clear();
    watermelon.clear();
    orange.clear();
    blueberry.clear();
    mango.clear();
    apple.clear();
    eggplant.clear();
    greenchili.clear();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  getfile(files) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$files');
    return file;
  }

  changeusername() async {
    var cek = 0;
    if (name.text == "" || pwd.text == "") {
      _showDialog("Warning", "Username or Password can't be empty");
      setState(() {
        lx = 0;
      });
    } else if (name.text != "" && pwd.text != "") {
      var email = await read('token.txt');
      var id;
      id = await Firestore.instance
          .collection('akun')
          .getDocuments()
          .then((value) => id = value.documents);
      for (var i = 0; i < id.length; i++) {
        // print(i);
        if (id[i]['email'] == email && id[i]['pass'] == pwd.text) {
          var doc = id[i].documentID;
          await Firestore.instance
              .collection('akun')
              .document(doc)
              .updateData({'username': name.text});
          setState(() {
            profil[0].name = name.text;
          });
          cek = 1;
          setState(() {
            b = 1;
            lx = 0;
            name.clear();
            pwd.clear();
            change = 0;
          });
          _showDialog("Success", "username changed");
        }
      }
      if (cek == 0) {
        setState(() {
          lx = 0;
          name.clear();
          pwd.clear();
        });
        _showDialog("Failed", "password is wrong");
      }
    }
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

  changepass() async {
    var cek = 0;
    if (npwd.text == "" || nnpwd.text == "") {
      _showDialog("Warning", "Password can't be empty");
      setState(() {
        lx = 0;
      });
    } else if (npwd.text != "" && nnpwd.text != "") {
      // print("start");
      var email = await read('token.txt');
      var id;
      id = await Firestore.instance
          .collection('akun')
          .getDocuments()
          .then((value) => id = value.documents);
      for (var i = 0; i < id.length; i++) {
        // print(i);
        if (id[i]['email'] == email && id[i]['pass'] == npwd.text) {
          // print("object");
          var doc = id[i].documentID;
          await Firestore.instance
              .collection('akun')
              .document(doc)
              .updateData({'pass': nnpwd.text});
          _showDialog("Success", "Password has been changed, please re login");
          cek = 1;
        }
      }
      if (cek == 0) {
        _showDialog("Failed", "old password is wrong");
        setState(() {
          lx = 0;
          npwd.clear();
          nnpwd.clear();
        });
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.05),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.width * 0.05,
                        color: Color.fromRGBO(0, 0, 0, 0.54),
                      ),
                      onPressed: () {
                        b == 1
                            ? Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => Bottom()))
                            : Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.2,
                        top: MediaQuery.of(context).size.width * 0.052),
                    child: Text(
                      "PROFILE SETTINGS",
                      style: TextStyle(
                          color: Color.fromRGBO(198, 198, 198, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.034,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075,
                        top: MediaQuery.of(context).size.width * 0.4),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: change == 0
                            ? Row(
                                children: <Widget>[
                                  Text(
                                    profil[0].name,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          change = 1;
                                          changes = 0;
                                        });
                                      })
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextFormField(
                                        controller: name,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "new username")),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: TextFormField(
                                        controller: pwd,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText:
                                                "enter you password to verify")),
                                  ),
                                ],
                              )),
                  ),
                  // Padding(
                  //       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075, top: MediaQuery.of(context).size.width * 0.04),
                  //       child: Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: Text(
                  //             "Email",
                  //             style: TextStyle(
                  //                 fontSize: MediaQuery.of(context).size.width * 0.045,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: Colors.black),
                  //           )),
                  //     ),
                  //      Padding(
                  //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075, top: MediaQuery.of(context).size.height * 0.02),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width * 0.85,
                  //       height: MediaQuery.of(context).size.height * 0.07,
                  //       child: TextFormField(
                  //         controller: mail,
                  //           decoration: InputDecoration(
                  //               border: OutlineInputBorder(),
                  //               hintText: "your@email.com")),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075,
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: changes == 0
                          ? Row(
                              children: <Widget>[
                                Text("********"),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        changes = 1;
                                        change = 0;
                                      });
                                    })
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: TextFormField(
                                    controller: npwd,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Old Password"),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: TextFormField(
                                    controller: nnpwd,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "New Password"),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(125, 209, 151, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        lx = 1;
                                      });
                                      changepass();
                                    },
                                    child: Center(
                                        child: lx == 1
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color.fromRGBO(
                                                            57, 96, 69, 1)),
                                              )
                                            : Text(
                                                "Save change",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        57, 96, 69, 1),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.045,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          lx = 1;
                        });

                        changeusername();
                        // cek();
                        // cekakun();
                        // getData();
                      },
                      child: change == 0
                          ? Text("")
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(125, 209, 151, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: lx == 1
                                      ? CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color.fromRGBO(57, 96, 69, 1)),
                                        )
                                      : Text(
                                          "Save change",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(57, 96, 69, 1),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045,
                                              fontWeight: FontWeight.w700),
                                        )),
                            ),
                    ),
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
