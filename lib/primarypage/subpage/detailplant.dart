import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';

class Detailplant extends StatefulWidget {
  @override
  _DetailplantState createState() => _DetailplantState();
}

class _DetailplantState extends State<Detailplant> {
  var lx = "";

  updateSP(index) async {
    var ph = tampilsp[index].ph;
    var tds = tampilsp[index].nutrisi;
    var lampuab = tampilsp[index].lampu;
    await FirebaseDatabase.instance.reference().child("/Control").update({
      'ControlSystem':
          '#' + "$ph" + "#" + '$tds' + '#' + '$lampuab' + '#' + '$lampuab' + '#'
    });
    await FirebaseDatabase.instance
        .reference()
        .child("/Control")
        .update({'FlagSystem': 1});
    //  _showDialog("Information", "wait a minute");
    await Firestore.instance
        .collection('Setpoint')
        .document('3CxhMBc1tUYjwviiAwjq')
        .updateData({
      "lampu": tampilsp[index].lampu,
      "nutrisi": tampilsp[index].nutrisi,
      "ph": tampilsp[index].ph
    });
    tambahbuah(index);
  }

  update() async {
    var val;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    // final List<DocumentSnapshot> documents = result.documents;
    // print(documents.)
    if (val.length >= 2) {
      var doc = val[1].documentID;
      var waktu = Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch);
      await Firestore.instance
          .collection('tanaman')
          .document(doc)
          .updateData({'tanggal panen': waktu});
    }
    tampilan.clear();
    tampilan.add(Buah1(sp[0].buah, sp[0].image, sp[0].latin, sp[0].colorval));
    await getfruit();
    setState(() {
      lx = '';
    });
    _showDialog(
        "Information", "Success to change, let's check your home screen");
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
              print(val[i]['buah']);
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
          // var tgl = DateFormat('y-e-d ').format(date2);

        }
      }
    }
  }

  tambahbuah(index) async {
    // var time = DateTime.now().millisecondsSinceEpoch.toString();
    var waktu = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    await Firestore.instance.collection('tanaman').document().setData({
      "buah": sp[0].buah,
      "SP": tampilsp[index].namasp,
      "tanggal tanam": waktu,
      "tanggal panen": "",
      "jsp": 1
    });
    update();
    // await Firestore.instance.collection('tanaman').where('buah',isEqualTo: tampilan[0].buah).
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

  @override
  void dispose() {
    // TODO: implement dispose
    // print("object");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                      top: MediaQuery.of(context).size.height * 0.018),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Color.fromRGBO(0, 0, 0, 0.54),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      "assets/Rectangle 46.svg",
                      width: MediaQuery.of(context).size.width * 0.8,
                      color: sp[0].colorval,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.15,
                      top: MediaQuery.of(context).size.height * 0.078),
                  child: SvgPicture.asset(
                    sp[0].image,
                    height: MediaQuery.of(context).size.height * 0.38,
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.45),
                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            sp[0].buah,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Inter",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                                color: sp[0].colorval),
                          )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            sp[0].latin,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.038,
                                color: Color.fromRGBO(186, 186, 186, 1)),
                          )),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 8.0),
                      //   child:
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Apakah anda ingin menanam " + sp[0].buah + " ?",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Inter normal",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.grey[600]),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.18,
                                width: MediaQuery.of(context).size.width * 0.18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 5,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          0.045),
                                  child: Column(
                                    children: <Widget>[
                                      // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                      Column(
                                        children: <Widget>[
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                              child: Image.asset(
                                                "assets/image 3.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.015),
                                            child: Text(
                                              tampilsp[index].lampu,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                  color: Color.fromRGBO(
                                                      104, 223, 85, 1),
                                                  fontWeight: FontWeight.w700),
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
                              height: MediaQuery.of(context).size.width * 0.18,
                              width: MediaQuery.of(context).size.width * 0.18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.055),
                                child: Column(
                                  children: <Widget>[
                                    // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.00,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.00),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          child: Image.asset(
                                            "assets/image 10.png",
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        tampilsp[index].ph,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color:
                                                Color.fromRGBO(104, 223, 85, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.18,
                              width: MediaQuery.of(context).size.width * 0.18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.055),
                                child: Column(
                                  children: <Widget>[
                                    // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.00,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.00),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          child: Image.asset(
                                            "assets/image 11.png",
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Text(
                                        tampilsp[index].nutrisi,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color:
                                                Color.fromRGBO(104, 223, 85, 1),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tampilsp[index].namasp,
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    // fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                                width: MediaQuery.of(context).size.width * 0.17,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 8,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          lx = index.toString();
                                        });
                                        updateSP(
                                            tampilsp.length == 0 ? 0 : index);
                                      },
                                      child: lx == index.toString()
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      sp[0].colorval),
                                            )
                                          : Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: sp[0].colorval,
                                                  fontFamily: 'Inter'),
                                            )),
                                ),
                              )
                            ],
                          )
                        ],
                        //   );
                        // },
                        //     itemCount: 10,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
                itemCount: tampilsp.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              ),
            )
          ]),
        ));
  }
}
