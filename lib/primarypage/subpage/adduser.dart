import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';

class Adduser extends StatefulWidget {
  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
// int selectedRadio;
  var lx = 0;

  TextEditingController mail = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController name = new TextEditingController();

  // setSelectedradio(int val){
  //   setState(() {
  //     selectedRadio = val;
  //   });
  // }

  add() async {
    await Firestore.instance.collection('akun').document().setData({
      "username": name.text,
      "email": mail.text,
      "role": "user",
      "pass": pwd.text,
      "foto": ""
    });
    setState(() {
      jumlahuser[0] = jumlahuser[0] + 1;
      lx = 0;
      mail.clear();
      pwd.clear();
      name.clear();
      _showDialog("Success", "Success added new user");
    });
  }

  cek() {
    if (mail.text == "" || name.text == "" || pwd.text == "") {
      _showDialog("Warning", "Email , password and username can't be empty");
      setState(() {
        lx = 0;
      });
    } else if (mail.text != "" && name.text != "" && pwd.text != "") {
      add();
    }
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
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) => Bottom()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // selectedRadio = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
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
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.22,
                      top: MediaQuery.of(context).size.width * 0.052),
                  child: Text(
                    "ADD NEW USER",
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
                          controller: name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "username")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.075,
                      top: MediaQuery.of(context).size.width * 0.04),
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
                // Padding(
                //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.055,top: MediaQuery.of(context).size.height * 0.02 ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Row(
                //         children: <Widget>[
                //           Radio(value: 1, groupValue: selectedRadio, onChanged: (val){setSelectedradio(val);}),
                //           Text(
                //             "Admin",
                //             style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
                //           ),
                //         ],
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075, ),
                //         child: Row(
                //           children: <Widget>[
                //             Radio(value: 2, groupValue: selectedRadio, onChanged: (val){setSelectedradio(val);}),
                //             Text("User", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        lx = 1;
                      });
                      cek();
                      // cekakun();
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
                                  "Add User",
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
