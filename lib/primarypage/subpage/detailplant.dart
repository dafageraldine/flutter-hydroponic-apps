import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:hydroponic/primarypage/subpage/addsp.dart';
import 'package:hydroponic/primarypage/subpage/editspupdate.dart';

import 'editsp.dart';

class Detailplant extends StatefulWidget {
  @override
  _DetailplantState createState() => _DetailplantState();
}

class _DetailplantState extends State<Detailplant> {
  var lx = "";

  void pesan(judul, konten) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  updateSP(index) async {
    var valz;
    var titless;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => valz = value.documents);
    for (var i = 0; i < valz.length; i++) {
      if (valz[i]['tanggal panen'] == "") {
        var jsp = valz[i]['jsp'];
        jsp == 1 ? titless = valz[i]['SP'] : titless = valz[i]['sp' + "$jsp"];
        var buahedits = valz[i]['buah'];
        if (titless == tampilsp[index].namasp && sp[0].buah == buahedits) {
          pesan("Failed", "You are currently using this setting point");
          setState(() {
            lx = '';
          });
        } else if (tampilsp[index].namasp != titless ||
            sp[0].buah != buahedits) {
          // print("dddd");
          var ph = tampilsp[index].ph;
          var tds = tampilsp[index].nutrisi;
          var lampuab = tampilsp[index].lampu;
          await FirebaseDatabase.instance.reference().child("/Control").update({
            'ControlSystem': '#' +
                "$ph" +
                "#" +
                '$tds' +
                '#' +
                '$lampuab' +
                '#' +
                '$lampuab' +
                '#'
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
      }
    }
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
    // tampilan.clear();
    // tampilan.add(Buah1(sp[0].buah, sp[0].image, sp[0].latin, sp[0].colorval));
    getcustomplant();
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
      getfruitall();
      // getspcustomplant();
    } else {
      getfruit();
      // Navigator.of(context, rootNavigator: true)
      //     .push(MaterialPageRoute(builder: (context) => Listallplant()));
    }
  }

  getfruitall() async {
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
          for (var k = 0; k < custom.length; k++) {
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
          for (var k = 0; k < custom.length; k++) {
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
    setState(() {
      lx = '';
    });
    await Firestore.instance.collection('activity').document().setData({
      "by": profil[0].email,
      "jenis": "tambah",
      "pesan": sp[0].buah,
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });

    getnotif();

    _showDialog(
        "Information", "Success to change, let's check your home screen");
  }

  Future getnotif() async {
    // var buah = nama.text;
    http.Response cek =
        await http.get(linkApi + "send_notifications_menanam/" + sp[0].buah);
    // print(linkApi + "send_notifications_tambahtanaman/" + "$buah");
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
          // for(var k = 0; k < custom.length; k++ ){

          // }
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
    setState(() {
      lx = '';
    });
    await Firestore.instance.collection('activity').document().setData({
      "by": profil[0].email,
      "jenis": "tambah",
      "pesan": sp[0].buah,
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });

    getnotif();
    _showDialog(
        "Information", "Success to change, let's check your home screen");
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

  Future deletesp(iter) async {
    var val;
    await Firestore.instance
        .collection('setpoint-collection')
        .where("buah", isEqualTo: sp[0].buah)
        .where("spname", isEqualTo: tampilsp[iter].namasp)
        .getDocuments()
        .then((value) => val = value.documents);
    var doc = val[0].documentID;
    await Firestore.instance
        .collection('setpoint-collection')
        .document(doc)
        .delete();
    await Firestore.instance.collection('activity').document().setData({
      "by": profil[0].email,
      "jenis": "ubah",
      "pesan": "removed Setting point " + tampilsp[iter].namasp,
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });
    Navigator.of(context).pop();
    _showDialog("Success", "data has been deleted successfully !");
  }

  get_fruitandspname_latest() async {
    var val;
    var titless;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    for (var i = 0; i < val.length; i++) {
      if (val[i]['tanggal panen'] == "") {
        var jsp = val[i]['jsp'];
        jsp == 1 ? titless = val[i]['SP'] : titless = val[i]['sp' + "$jsp"];
        var buahedits = val[i]['buah'];
        if (titles == titless && buahedit == buahedits) {
          print("object");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Editupdate()));
        } else if (titles != titless || buahedit != buahedits) {
          // print("dddd");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Edit()));
        }
      }
    }
  }

  void _showDialogx(judul, konten, iter) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(judul),
          content: new Text(konten),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Edit",
                style: TextStyle(color: Colors.green[400]),
              ),
              onPressed: () async {
                nutrisig = tampilsp[iter].nutrisi;
                lampug = tampilsp[iter].lampu;
                phg = tampilsp[iter].ph;
                buahedit = sp[0].buah;
                titles = tampilsp[iter].namasp;
                await get_fruitandspname_latest();
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Edit()));
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Delete",
                style: TextStyle(color: Colors.green[400]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialogxx(
                    "Warning",
                    "Are you sure you want to delete " + tampilsp[iter].namasp,
                    iter);
              },
            ),
          ],
        );
      },
    );
  }

  var hold = 0;

  void _showDialogxx(judul, konten, iter) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(judul),
          content: new Text(konten),
          actions: <Widget>[
            new FlatButton(
              child: hold == 1
                  ? CircularProgressIndicator()
                  : new Text(
                      "Yes",
                      style: TextStyle(color: Colors.green[400]),
                    ),
              onPressed: () async {
                setState(() {
                  hold = 1;
                });
                await deletesp(iter);
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "No",
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              sp[0].deskripsi,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Inter",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  color: Color.fromRGBO(186, 186, 186, 1)),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Setting Point Lists",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Inter",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.032,
                                    color: Colors.grey[600]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.12),
                                child: InkWell(
                                  onTap: () {
                                    vgtanaman = sp[0].buah;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Addedit()));
                                  },
                                  child: Text(
                                    "Add New",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Inter normal",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.032,
                                      color: Color.fromRGBO(96, 168, 90, 1),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02,
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
                              Row(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: sp[0].colorval,
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
                                            updateSP(tampilsp.length == 0
                                                ? 0
                                                : index);
                                          },
                                          child: lx == index.toString()
                                              ? CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                )
                                              : Text(
                                                  "Use",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      color: Colors.white,
                                                      fontFamily: 'Inter'),
                                                )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showDialogx(
                                          "Information",
                                          "Do you want to delete or edit " +
                                              tampilsp[index].namasp +
                                              " ?",
                                          index);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.13,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[300],
                                                blurRadius: 8,
                                                offset: Offset(0, 2))
                                          ]),
                                      child: Center(
                                          child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color: sp[0].colorval,
                                            fontFamily: 'Inter'),
                                      )),
                                    ),
                                  ),
                                ],
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
