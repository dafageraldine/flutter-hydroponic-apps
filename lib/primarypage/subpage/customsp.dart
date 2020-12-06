import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Settingpoint extends StatefulWidget {
  @override
  _SettingpointState createState() => _SettingpointState();
}

class _SettingpointState extends State<Settingpoint> {
  var buahs;
  var t;
  var lx = 1;

  TextEditingController ph = new TextEditingController();
  TextEditingController nutrisi = new TextEditingController();
  TextEditingController lampu = new TextEditingController();
  TextEditingController name = new TextEditingController();

  gettime() {
    var tgl = DateTime.now();
    var tgl2 = DateFormat('EEE , d LLL y').format(tgl);
    // var tgl3 = DateFormat('d LLL y').format(tgl);
    setState(() {
      t = tgl2;

      // ts = tgl3;
    });
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

  Future getnotif() async {
    // var buah = nama.text;
    http.Response cek = await http
        .get(linkApi + "send_notifications_menambahsetpoint/" + name.text);
    // print(linkApi + "send_notifications_tambahtanaman/" + "$buah");
  }

  updateSP() async {
    var phs = ph.text;
    var tds = nutrisi.text;
    var lamp = lampu.text;
    // ceker();
    if (lampu.text != "" &&
        nutrisi.text != "" &&
        ph.text != "" &&
        name.text != "" &&
        buahs != null) {
      phs = phs.contains(",") ? phs.replaceAll(",", ".") : phs;
      tds = tds.contains(",") ? tds.replaceAll(",", ".") : tds;
      lamp = lamp.contains(",") ? lamp.replaceAll(",", ".") : lamp;
      var cek = ".".allMatches(phs).length;
      var cek2 = ".".allMatches(tds).length;
      var cek3 = ".".allMatches(lamp).length;
      if (cek > 1 || cek2 > 1 || cek3 > 1) {
        lx = 1;
        setState(() {});
        _showDialog(
            "Failed", "sensor value can't contains ' , ' or ' . ' more than 1");
      } else if (cek <= 1 && cek2 <= 1 && cek3 <= 1) {
        await Firestore.instance
            .collection('setpoint-collection')
            .document()
            .setData({
          'buah': buahs,
          'spname': name.text,
          'value': '#' + '$phs' + '#' + '$lamp' + '#' + '$tds',
        });
        // if (tampilan[0].buah == buahs) {
        //   var val;
        //   await Firestore.instance
        //       .collection('Setpoint')
        //       .document('3CxhMBc1tUYjwviiAwjq')
        //       .updateData({
        //     "lampu": lampu.text,
        //     "nutrisi": nutrisi.text,
        //     "ph": ph.text
        //   });
        //   await FirebaseDatabase.instance.reference().child("/Control").update({
        //     'ControlSystem': '#' +
        //         "$phs" +
        //         "#" +
        //         '$tds' +
        //         '#' +
        //         '$lamp' +
        //         '#' +
        //         '$lamp' +
        //         '#'
        //   });
        //   await FirebaseDatabase.instance
        //       .reference()
        //       .child("/Control")
        //       .update({'FlagSystem': 1});
        //   await Firestore.instance
        //       .collection('tanaman')
        //       .orderBy("tanggal tanam", descending: true)
        //       .getDocuments()
        //       .then((value) => val = value.documents);
        //   // print(val[0]['buah']);
        //   var jsp = val[0]['jsp'];
        //   var next = jsp + 1;
        //   var doc = val[0].documentID;

        //   Timestamp times = val[0]['tanggal tanam'];
        //   var dates = DateTime.parse(times.toDate().toString());
        //   var converts = DateTime(dates.year, dates.month, dates.day);

        //   var waktu = DateTime.now();
        //   var conv = DateTime(waktu.year, waktu.month, waktu.day);

        //   var difference = conv.difference(converts).inDays;
        //   // print(difference);
        //   if (difference != 0) {
        //     await Firestore.instance
        //         .collection('tanaman')
        //         .document(doc)
        //         .updateData({
        //       'jsp': next,
        //       'sp' + '$next': name.text,
        //       'startsp' + '$next': difference
        //     });
        //   } else if (difference == 0) {
        //     await Firestore.instance
        //         .collection('tanaman')
        //         .document(doc)
        //         .updateData({
        //       // 'jsp': next,
        //       'SP': name.text,
        //       // 'startsp' +'$next' : difference
        //     });
        //   }

        //   await Firestore.instance.collection('activity').document().setData({
        //     "by": profil[0].email,
        //     "jenis": "ubah",
        //     "pesan": "updated Setting Point " + "$buahs",
        //     "tanggal": Timestamp.fromMillisecondsSinceEpoch(
        //         DateTime.now().millisecondsSinceEpoch)
        //   });
        //   getnotif();
        //   _showDialog("Success", "New Setpoint added for $buahs");
        //   lampu.clear();
        //   nutrisi.clear();
        //   ph.clear();
        //   name.clear();
        //   buahs = "";

        //   setState(() {
        //     lx = 1;
        //   });
        //   // await getsetpoint();
        // }
        //  if (tampilan[0].buah != buahs) {
        // await getsetpoint();
        await Firestore.instance.collection('activity').document().setData({
          "by": profil[0].email,
          "jenis": "ubah",
          "pesan": "added Setting Point " + "$buahs",
          "tanggal": Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch)
        });
        getnotif();
        _showDialog("Success", "New Setpoint added for $buahs");
        lampu.clear();
        nutrisi.clear();
        ph.clear();
        name.clear();
        buahs = "";

        setState(() {
          lx = 1;
        });
      }
    } else {
      // print("object");
      _showDialog("Failed", "tidak boleh ada kolom yang kosong");
      lx = 1;
      setState(() {});
    }
    // print(ph.text);
  }

  // getsetpoint() async {
  //   strawberry.clear();
  //   tomato.clear();
  //   watermelon.clear();
  //   orange.clear();
  //   blueberry.clear();
  //   mango.clear();
  //   apple.clear();
  //   eggplant.clear();
  //   greenchili.clear();
  //   var datasp;
  //   await Firestore.instance
  //       .collection('setpoint-collection')
  //       .getDocuments()
  //       .then((value) => datasp = value.documents);

  //   for (var i = 0; i < datasp.length; i++) {
  //     if (datasp[i]['buah'] == "Strawberry") {
  //       var vals = datasp[i]['value'].split('#');
  //       strawberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Tomato") {
  //       var vals = datasp[i]['value'].split('#');
  //       tomato.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Orange") {
  //       var vals = datasp[i]['value'].split('#');
  //       orange.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Apple") {
  //       var vals = datasp[i]['value'].split('#');
  //       apple.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Egg Plant") {
  //       var vals = datasp[i]['value'].split('#');
  //       eggplant.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Blueberry") {
  //       var vals = datasp[i]['value'].split('#');
  //       blueberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Mango") {
  //       var vals = datasp[i]['value'].split('#');
  //       mango.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Watermelon") {
  //       var vals = datasp[i]['value'].split('#');
  //       watermelon.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     } else if (datasp[i]['buah'] == "Green Chili") {
  //       var vals = datasp[i]['value'].split('#');
  //       greenchili.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
  //           vals[2].toString(), vals[3].toString()));
  //     }
  //   }
  // }

  daftarbuah(fotobuah, buah, jarak) {
    return GestureDetector(
      onTap: () {
        setState(() {
          buahs = buah;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(left: jarak),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.20,
              width: MediaQuery.of(context).size.width * 0.20,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: buahs == buah ? Colors.green : Colors.white),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: Stack(
                children: <Widget>[
                  Center(
                      child: SvgPicture.asset(fotobuah,
                          height: MediaQuery.of(context).size.width * 0.12,
                          width: MediaQuery.of(context).size.width * 0.12)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02),
              child: Text(
                buah,
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    color: buahs == buah
                        ? Color.fromRGBO(82, 82, 82, 1)
                        : Color.fromRGBO(182, 182, 182, 1)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    gettime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: MediaQuery.of(context).size.width * 0.05,
                            color: Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bottom()));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: Text(
                            "CUSTOM SETTING POINT",
                            style: TextStyle(
                                color: Color.fromRGBO(198, 198, 198, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Setting Point",
                          style: TextStyle(
                              color: Color.fromRGBO(82, 82, 82, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Inter'),
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
                              color: Color.fromRGBO(183, 183, 183, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.0380),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                  hintText: "Insert setting point name here")),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Plants",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromRGBO(132, 132, 132, 1),
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
                            top: MediaQuery.of(context).size.width * 0.005),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: Text(
                            "Pick 1 plant",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(181, 181, 181, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.28,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          daftarbuah("assets/tomato.svg", "Tomato",
                              MediaQuery.of(context).size.width * 0.08),
                          daftarbuah("assets/mango.svg", "Mango",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/apple.svg", "Apple",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah(
                              "assets/green-chili-pepper.svg",
                              "Green Chili",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/strawberry.svg", "Strawberry",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/eggplant.svg", "Egg Plant",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/blueberry.svg", "Blueberry",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/orange.svg", "Orange",
                              MediaQuery.of(context).size.width * 0.02),
                          daftarbuah("assets/watermelon.svg", "Watermelon",
                              MediaQuery.of(context).size.width * 0.02),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    buahs = custom[index].nama;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color:
                                                    buahs == custom[index].nama
                                                        ? Colors.green
                                                        : Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                                child: SvgPicture.asset(
                                                    "assets/customplant.svg",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.12,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.12)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Text(
                                          custom[index].nama,
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: buahs == custom[index].nama
                                                  ? Color.fromRGBO(
                                                      82, 82, 82, 1)
                                                  : Color.fromRGBO(
                                                      182, 182, 182, 1)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: custom.length,
                            physics: ClampingScrollPhysics(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04,
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Text(
                    "Sensors",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                        fontWeight: FontWeight.w600),
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
                                  // inputFormatters: <TextInputFormatter>[
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.05),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                lx = 0;
                              });
                              updateSP();
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.83,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                "CREATE NOW",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w900,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                              )
                                            : CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ))),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //  SvgPicture.asset("assets/image 21.svg")          //  SizedBox(height: MediaQuery.of(context).size.width * 0.1,)
                    ],
                  ),
                ),
              ],
              physics: ClampingScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
