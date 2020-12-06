import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:http/http.dart' as http;
import 'package:hydroponic/primarypage/subpage/addsp.dart';
import 'package:hydroponic/primarypage/subpage/editsp.dart';
import 'package:hydroponic/primarypage/subpage/editspupdate.dart';

import '../bottom_nav.dart';

class Detailcustomplant extends StatefulWidget {
  @override
  _DetailcustomplantState createState() => _DetailcustomplantState();
}

class _DetailcustomplantState extends State<Detailcustomplant> {
  var isLoading = 0;
  var sp = "";
  var loading = 0;

  updateSP(index) async {
    var ph = customplant[index].ph;
    var tds = customplant[index].nutrisi;
    var lampuab = customplant[index].lampu;
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
      "lampu": customplant[index].lampu,
      "nutrisi": customplant[index].nutrisi,
      "ph": customplant[index].ph
    });
    tambahbuah(index);
  }

  tambahbuah(index) async {
    // var time = DateTime.now().millisecondsSinceEpoch.toString();
    var waktu = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    await Firestore.instance.collection('tanaman').document().setData({
      "buah": customplant[index].nama,
      "SP": customplant[index].namasp,
      "tanggal tanam": waktu,
      "tanggal panen": "",
      "jsp": 1
    });
    update();
    // await Firestore.instance.collection('tanaman').where('buah',isEqualTo: tampilan[0].buah).
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
    }
  }

  getcustomplants() async {
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
      // getfruitall();
      // getspcustomplant();
    }
  }

  Future getnotif() async {
    // var buah = nama.text;
    http.Response cek = await http
        .get(linkApi + "send_notifications_menanam/" + customdetail[0].nama);
    // print(linkApi + "send_notifications_tambahtanaman/" + "$buah");
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
    await Firestore.instance.collection('activity').document().setData({
      "by": profil[0].email,
      "jenis": "tambah",
      "pesan": customdetail[0].nama,
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });
    getnotif();
    setState(() {
      isLoading = 0;
    });
    _showDialog(
        "Information", "Success to change, let's check your home screen");
  }

  // getfruitk() async {
  //   // ceks.add(1);
  //   jumlahdata.clear();
  //   datareport.clear();
  //   foto.clear();
  //   color.clear();
  //   var val;
  //   await Firestore.instance
  //       .collection('tanaman')
  //       .orderBy("tanggal tanam", descending: true)
  //       .getDocuments()
  //       .then((value) => val = value.documents);
  //   print(val.length);
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
  //             // print('$difference' + 'day');
  //             jumlahdata.add(difference);
  //             datareport.add(
  //                 Report(val[i]['buah'], date.toString(), date2.toString()));
  //           }
  //         }
  //         // for(var k = 0; k < custom.length; k++ ){

  //         // }
  //       } else if (val[i]['tanggal panen'] == "") {
  //         Timestamp timestamp = val[i]['tanggal tanam'];
  //         var date = DateTime.parse(timestamp.toDate().toString());
  //         // Timestamp timestamps = val[i]['tanggal panen'];
  //         var date2 = DateTime.now();
  //         for (var y = 0; y < datab.length; y++) {
  //           if (val[i]['buah'] == datab[y].buah) {
  //             print(val[i]['buah']);
  //             foto.add(datab[y].image);
  //             color.add(datab[y].colorval);
  //             var tgl = DateTime(date.year, date.month, date.day);
  //             var tgl2 = DateTime(date2.year, date2.month, date2.day + 1);
  //             final difference = tgl2.difference(tgl).inDays;
  //             print('$difference' + 'day');
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
  //   await Firestore.instance.collection('activity').document().setData({
  //     "by": profil[0].email,
  //     "jenis": "tambah",
  //     "pesan": customdetail[0].nama,
  //     "tanggal": Timestamp.fromMillisecondsSinceEpoch(
  //         DateTime.now().millisecondsSinceEpoch)
  //   });
  //   getnotif();
  //   setState(() {
  //     isLoading = 0;
  //   });
  //   _showDialog(
  //       "Information", "Success to change, let's check your home screen");
  // }

  void _showDialog(judul, konten) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: onWillPop,
          child: AlertDialog(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bottom()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future prompt() async {
    var val;
    await Firestore.instance
        .collection('tanaman')
        .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    if (val.isNotEmpty) {
      if (val[0]['buah'] == customdetail[0].nama) {
        _showDialogs("Failed!", "you're still growing this plant");
      } else {
        _showDialogss(
            "Warning!",
            "are you sure, you want to delete " +
                customdetail[0].nama +
                " plant ?");
      }
      // print(val[val.length - 1]['buah']);
    }
  }

  Future deleteplant() async {
    var val;
    var vals;
    var id;
    await Firestore.instance
        .collection('customplant')
        .where(
          'tanaman',
          isEqualTo: customdetail[0].nama,
        )
        .where("status", isEqualTo: "aktif")
        // .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    var doc = val[0].documentID;
    await Firestore.instance
        .collection('customplant')
        .document(doc)
        .updateData({'status': "tidak aktif"});
    await Firestore.instance
        .collection('setpoint-collection')
        .where(
          'buah',
          isEqualTo: customdetail[0].nama,
        )
        // .orderBy("tanggal tanam", descending: true)
        .getDocuments()
        .then((value) => vals = value.documents);
    for (var i = 0; i < vals.length; i++) {
      id = vals[i].documentID;
      await Firestore.instance
          .collection('setpoint-collection')
          .document(id)
          .delete();
    }

    await Firestore.instance.collection('activity').document().setData({
      "by": profil[0].email,
      "jenis": "ubah",
      "pesan": "removed " + customdetail[0].nama + " plant",
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });
    setState(() {
      loading = 0;
    });
    getcustomplants();
    Navigator.of(context).pop();
    _showDialog("Success", "data has been deleted successfully !");
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

  DateTime backbuttonpressedTime;
  // var val;
  // var lx = 0;
  // var kunci;

  Future deletesp(iter) async {
    var val;
    await Firestore.instance
        .collection('setpoint-collection')
        .where("buah", isEqualTo: customdetail[0].nama)
        .where("spname", isEqualTo: customplant[iter].namasp)
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
      "pesan": "removed Setting point " + customplant[iter].namasp,
      "tanggal": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });
    Navigator.of(context).pop();
    _showDialog("Success", "data has been deleted successfully !");
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

  void _showDialogss(judul, konten) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: onWillPop,
          child: AlertDialog(
            title: new Text(judul),
            content: new Text(konten),
            actions: <Widget>[
              new FlatButton(
                child: loading == 1
                    ? CircularProgressIndicator()
                    : new Text(
                        "Yes",
                        style: TextStyle(color: Colors.green[400]),
                      ),
                onPressed: () async {
                  setState(() {
                    loading = 1;
                  });
                  await deleteplant();
                  // Navigator.of(context).pop();
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
          ),
        );
      },
    );
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
          print("dddd");
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
                nutrisig = customplant[iter].nutrisi;
                lampug = customplant[iter].lampu;
                phg = customplant[iter].ph;
                buahedit = customdetail[0].nama;
                titles = customplant[iter].namasp;
                await get_fruitandspname_latest();
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
                    "Are you sure you want to delete " +
                        customplant[iter].namasp,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: MediaQuery.of(context).size.width * 0.75,
            //       top: MediaQuery.of(context).size.height * 0.47),
            //   child:
            // ),
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
                  color: Colors.green[200],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  top: MediaQuery.of(context).size.height * 0.078),
              child: SvgPicture.asset(
                "assets/customplant.svg",
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.46),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customdetail[0].nama,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Inter",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.08,
                                    color: Colors.green[200]),
                              ),
                              Text(
                                customdetail[0].latin,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(186, 186, 186, 1)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.02,
                                right: MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    prompt();
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white),
                                    child: SvgPicture.asset("assets/bin.svg"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Text(
                                    "Delete plant",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        color: Colors.grey[600],
                                        // fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          customdetail[0].deskripsi,
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
                    height: 10,
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
                                    MediaQuery.of(context).size.width * 0.032,
                                color: Colors.grey[600]),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.05,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.12),
                            child: InkWell(
                              onTap: () {
                                vgtanaman = customdetail[0].nama;
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
                                      MediaQuery.of(context).size.width * 0.032,
                                  color: Color.fromRGBO(96, 168, 90, 1),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return customplant[index].nama == customdetail[0].nama
                          ? Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[300],
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2))
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                        0.01),
                                                child: Text(
                                                  customplant[index].lampu,
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                      0.01),
                                              child: Text(
                                                customplant[index].ph,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
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
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text(
                                              customplant[index].nutrisi,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          customplant[index].namasp,
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              // fontWeight: FontWeight.w500,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Color.fromRGBO(
                                                      104, 223, 85, 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[300],
                                                        blurRadius: 8,
                                                        offset: Offset(0, 2))
                                                  ]),
                                              child: Center(
                                                child: sp ==
                                                        customplant[index]
                                                            .namasp
                                                    ? CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            sp = customplant[
                                                                    index]
                                                                .namasp;
                                                          });
                                                          updateSP(index);
                                                        },
                                                        child: Text(
                                                          "Use",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Inter'),
                                                        )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _showDialogx(
                                                    "Information",
                                                    "Do you wan to delete or edit " +
                                                        customplant[index]
                                                            .namasp +
                                                        " ?",
                                                    index);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[300],
                                                          blurRadius: 8,
                                                          offset: Offset(0, 2))
                                                    ]),
                                                child: Center(
                                                    child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                      color: Color.fromRGBO(
                                                          104, 223, 85, 1),
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
                            )
                          : SizedBox(
                              width: 0,
                            );
                    },
                    itemCount: customplant.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       right: MediaQuery.of(context).size.width * 0.1),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.8,
                  //         height: MediaQuery.of(context).size.height * 0.11,
                  //         decoration: BoxDecoration(
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   blurRadius: 2,
                  //                   spreadRadius: 5,
                  //                   color: Colors.grey[300],
                  //                   offset: Offset(0, 5))
                  //             ],
                  //             color: Colors.white,
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10))),
                  //         child: Stack(
                  //           children: [
                  //             Padding(
                  //               padding: EdgeInsets.only(
                  //                   left: MediaQuery.of(context).size.width *
                  //                       0.05,
                  //                   top: MediaQuery.of(context).size.width *
                  //                       0.04),
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     width: MediaQuery.of(context).size.width *
                  //                         0.08,
                  //                     height:
                  //                         MediaQuery.of(context).size.width *
                  //                             0.08,
                  //                     decoration: BoxDecoration(
                  //                         border: Border.all(
                  //                           color:
                  //                               Color.fromRGBO(104, 223, 85, 1),
                  //                         ),
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color: Colors.grey[300],
                  //                             spreadRadius: 2,
                  //                             blurRadius: 2,
                  //                             offset: Offset(0, 5),
                  //                           ),
                  //                         ],
                  //                         borderRadius: BorderRadius.all(
                  //                             Radius.circular(10)),
                  //                         color: Colors.white),
                  //                     child: SvgPicture.asset("assets/bin.svg"),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.only(
                  //                         top: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height *
                  //                             0.01),
                  //                     child: Text(
                  //                       "Delete",
                  //                       style: TextStyle(
                  //                           fontFamily: "Inter",
                  //                           color: Colors.grey[700],
                  //                           // fontWeight: FontWeight.w500,
                  //                           fontSize: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.03),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Padding(
                  //                   padding: EdgeInsets.only(
                  //                       left:
                  //                           MediaQuery.of(context).size.width *
                  //                               0.2),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: <Widget>[
                  //                       Container(
                  //                           height: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.08,
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.08,
                  //                           child: SvgPicture.asset(
                  //                             "assets/lamp.svg",
                  //                             fit: BoxFit.fill,
                  //                           )),
                  //                       Padding(
                  //                         padding: EdgeInsets.only(
                  //                             top: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width *
                  //                                 0.01),
                  //                         child: Text(
                  //                           customplant[0].lampu,
                  //                           style: TextStyle(
                  //                               fontSize: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width *
                  //                                   0.03,
                  //                               color: Color.fromRGBO(
                  //                                   104, 223, 85, 1),
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsets.only(
                  //                       left:
                  //                           MediaQuery.of(context).size.width *
                  //                               0.02),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: <Widget>[
                  //                       // Image.asset("assets/iconfinder_24_4698595.png",height: MediaQuery.of(context).size.width * 0.23,width: MediaQuery.of(context).size.width * 0.23,),

                  //                       Container(
                  //                           height: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.08,
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.08,
                  //                           child: SvgPicture.asset(
                  //                             "assets/ph (2).svg",
                  //                             fit: BoxFit.fill,
                  //                           )),
                  //                       Padding(
                  //                         padding: EdgeInsets.only(
                  //                             top: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width *
                  //                                 0.01),
                  //                         child: Text(
                  //                           customplant[0].ph,
                  //                           style: TextStyle(
                  //                               fontSize: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width *
                  //                                   0.03,
                  //                               color: Color.fromRGBO(
                  //                                   104, 223, 85, 1),
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsets.only(
                  //                       left:
                  //                           MediaQuery.of(context).size.width *
                  //                               0.02),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       Container(
                  //                           height: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.08,
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.07,
                  //                           child: SvgPicture.asset(
                  //                             "assets/fertilizer.svg",
                  //                             fit: BoxFit.fill,
                  //                           )),
                  //                       SizedBox(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.01,
                  //                       ),
                  //                       Text(
                  //                         customplant[0].nutrisi,
                  //                         style: TextStyle(
                  //                             fontSize: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width *
                  //                                 0.03,
                  //                             color: Color.fromRGBO(
                  //                                 104, 223, 85, 1),
                  //                             fontWeight: FontWeight.w700),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.only(
                  //                   right: MediaQuery.of(context).size.width *
                  //                       0.02,
                  //                   top: MediaQuery.of(context).size.width *
                  //                       0.02),
                  //               child: Column(
                  //                 children: [
                  //                   Padding(
                  //                     padding: EdgeInsets.only(
                  //                         bottom: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.01,
                  //                         right: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.05),
                  //                     child: Align(
                  //                       alignment: Alignment.topRight,
                  //                       child: Text(
                  //                         customplant[0].namasp,
                  //                         style: TextStyle(
                  //                             fontFamily: "Inter",
                  //                             // color: Color.fromRGBO(
                  //                             //     104, 223, 85, 1),
                  //                             // fontWeight: FontWeight.w500,
                  //                             fontSize: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width *
                  //                                 0.03),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment: MainAxisAlignment.end,
                  //                     children: [
                  //                       Container(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.1,
                  //                         width: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.13,
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(10.0),
                  //                             color: Color.fromRGBO(
                  //                                 104, 223, 85, 1),
                  //                             boxShadow: [
                  //                               BoxShadow(
                  //                                   color: Colors.grey[300],
                  //                                   blurRadius: 8,
                  //                                   offset: Offset(0, 2))
                  //                             ]),
                  //                         child: Center(
                  //                           child: sp == customplant[0].namasp
                  //                               ? CircularProgressIndicator(
                  //                                   valueColor:
                  //                                       AlwaysStoppedAnimation<
                  //                                               Color>(
                  //                                           Colors.green[200]),
                  //                                 )
                  //                               : InkWell(
                  //                                   onTap: () {
                  //                                     // setState(() {
                  //                                     //   sp = customplant[
                  //                                     //           index]
                  //                                     //       .namasp;
                  //                                     // });
                  //                                     // updateSP(index);
                  //                                   },
                  //                                   child: Text(
                  //                                     "Yes",
                  //                                     style: TextStyle(
                  //                                         fontSize: MediaQuery.of(
                  //                                                     context)
                  //                                                 .size
                  //                                                 .width *
                  //                                             0.03,
                  //                                         color: Colors.white,
                  //                                         fontFamily: 'Inter'),
                  //                                   )),
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         width: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.01,
                  //                       ),
                  //                       Container(
                  //                         width: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.13,
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.1,
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(10.0),
                  //                             color: Colors.white,
                  //                             boxShadow: [
                  //                               BoxShadow(
                  //                                   color: Colors.grey[300],
                  //                                   blurRadius: 8,
                  //                                   offset: Offset(0, 2))
                  //                             ]),
                  //                         child: Center(
                  //                             child: Text(
                  //                           "Edit",
                  //                           style: TextStyle(
                  //                               fontSize: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width *
                  //                                   0.03,
                  //                               color: Color.fromRGBO(
                  //                                   104, 223, 85, 1),
                  //                               fontFamily: 'Inter'),
                  //                         )),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
