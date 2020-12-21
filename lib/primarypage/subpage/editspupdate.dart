import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';

class Editupdate extends StatefulWidget {
  @override
  _EditupdateState createState() => _EditupdateState();
}

class _EditupdateState extends State<Editupdate> {
  @override
  void initState() {
    lampu.text = lampug;
    nutrisi.text = nutrisig;
    ph.text = phg;
    name.text = titles;
    super.initState();
  }

  var lx = 1;
  TextEditingController name = TextEditingController();
  TextEditingController lampu = TextEditingController();
  TextEditingController nutrisi = TextEditingController();
  TextEditingController ph = TextEditingController();

  Future editsp() async {
    if (name.text.isNotEmpty &&
        lampu.text.isNotEmpty &&
        nutrisi.text.isNotEmpty &&
        ph.text.isNotEmpty) {
      var phs = ph.text;
      var tds = nutrisi.text;
      var lamp = lampu.text;
      phs = phs.contains(",") ? phs.replaceAll(",", ".") : phs;
      tds = tds.contains(",") ? tds.replaceAll(",", ".") : tds;
      lamp = lamp.contains(",") ? lamp.replaceAll(",", ".") : lamp;
      var cek = ".".allMatches(phs).length;
      var cek2 = ".".allMatches(tds).length;
      var cek3 = ".".allMatches(lamp).length;
      if (cek > 1 || cek2 > 1 || cek3 > 1) {
        lx = 1;
        setState(() {});
        _showDialogs(
            "Failed", "sensor value can't contains ' , ' or ' . ' more than 1");
      } else if (cek <= 1 && cek2 <= 1 && cek3 <= 1) {
        var val;
        await Firestore.instance
            .collection('setpoint-collection')
            .where("buah", isEqualTo: buahedit)
            .where("spname", isEqualTo: titles)
            .getDocuments()
            .then((value) => val = value.documents);
        var doc = val[0].documentID;
        await Firestore.instance
            .collection('setpoint-collection')
            .document(doc)
            .updateData({
          'spname': name.text,
          'value': "#" + ph.text + "#" + lampu.text + "#" + nutrisi.text
        });

        await Firestore.instance
            .collection('Setpoint')
            .document('3CxhMBc1tUYjwviiAwjq')
            .updateData(
                {"lampu": lampu.text, "nutrisi": nutrisi.text, "ph": ph.text});
        await FirebaseDatabase.instance.reference().child("/Control").update({
          'ControlSystem':
              '#' + "$phs" + "#" + '$tds' + '#' + '$lamp' + '#' + '$lamp' + '#'
        });
        await FirebaseDatabase.instance
            .reference()
            .child("/Control")
            .update({'FlagSystem': 1});
        var vals;
        if (titles != name.text) {
          await Firestore.instance
              .collection('tanaman')
              .orderBy("tanggal tanam", descending: true)
              .getDocuments()
              .then((value) => vals = value.documents);
          // print(val[0]['buah']);
          var jsps = vals[0]['jsp'];
          var next = jsps + 1;
          var docs = vals[0].documentID;

          Timestamp times = vals[0]['tanggal tanam'];
          var dates = DateTime.parse(times.toDate().toString());
          var converts = DateTime(dates.year, dates.month, dates.day);

          var waktu = DateTime.now();
          var conv = DateTime(waktu.year, waktu.month, waktu.day);

          var difference = conv.difference(converts).inDays;
          // print(difference);
          if (difference != 0) {
            await Firestore.instance
                .collection('tanaman')
                .document(docs)
                .updateData({
              'jsp': next,
              'sp' + '$next': name.text,
              'startsp' + '$next': difference
            });
          } else if (difference == 0) {
            await Firestore.instance
                .collection('tanaman')
                .document(docs)
                .updateData({
              // 'jsp': next,
              'SP': name.text,
              // 'startsp' +'$next' : difference
            });
          }
        }

        await Firestore.instance.collection('activity').document().setData({
          "by": profil[0].email,
          "jenis": "ubah",
          "pesan": "added Setting Point " + name.text,
          "tanggal": Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch)
        });
        setState(() {
          lx = 1;
        });
        await getsetpoint();
        _showDialog("Success", "setpoint has been updated successfully");
      }
    } else {
      setState(() {
        lx = 1;
      });
      _showDialogs("Warning", "form can't be empty");
    }
  }

  void _showDialogs(judul, konten) {
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

  void _showDialog(judul, konten) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Bottom()));
              },
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(children: [
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/Rectangle 46.svg",
                width: MediaQuery.of(context).size.width * 0.8,
              )),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: MediaQuery.of(context).size.width * 0.05,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.22),
                  child: Text(
                    "Edit setting Point " + titles,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.width * 0.034,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.85),
              child: InkWell(
                onTap: () {
                  setState(() {
                    lx = 0;
                  });
                  editsp();
                  // updateSP();
                },
                child: Column(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.83,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color.fromRGBO(151, 241, 144, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 20,
                                  offset: Offset(0, 3))
                            ]),
                        child: Center(
                            child: lx == 1
                                ? Text(
                                    "UPDATE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w900,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ))),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Setting point name ",
                          style: TextStyle(
                              color: Color.fromRGBO(132, 132, 132, 1),
                              fontFamily: 'Inter',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.07,
                            top: MediaQuery.of(context).size.width * 0.00),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText:
                                      "Insert new setting point name here")),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.02,
                      left: MediaQuery.of(context).size.width * 0.07,
                    ),
                    child: Text(
                      "Sensors",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04,
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
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
                                              Center(
                                                  child: SvgPicture.asset(
                                                "assets/idea.svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              )),
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
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                                        Center(
                                            child: SvgPicture.asset(
                                                "assets/ph (2).svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1)),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Row(
                                        children: <Widget>[],
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
                                        Center(
                                            child: SvgPicture.asset(
                                                "assets/fertilizer.svg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1)),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Row(
                                        children: <Widget>[],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextFormField(
                                  controller: lampu,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  decoration: InputDecoration(

                                      // border: OutlineInputBorder(),

                                      // hintText: "Insert setting point name here"

                                      )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.14),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextFormField(
                                  controller: ph,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  decoration: InputDecoration(

                                      // border: OutlineInputBorder(),

                                      // hintText: "Insert setting point name here"

                                      )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.13),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  controller: nutrisi,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(

                                      // border: OutlineInputBorder(),

                                      // hintText: "Insert setting point name here"

                                      )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}
