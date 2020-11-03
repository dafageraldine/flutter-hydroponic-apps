import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/detailmonitoring.dart';
import 'package:hydroponic/primarypage/subpage/detailplant.dart';
import 'package:intl/intl.dart';

class Listreport extends StatefulWidget {
  @override
  _ListreportState createState() => _ListreportState();
}

class _ListreportState extends State<Listreport> {
  var t;
  var ts;
  var z;

  gettime() {
    var tgl = DateTime.now();
    var tgl2 = DateFormat('d LLL y').format(tgl);
    var tgl3 = DateFormat('EEEE').format(tgl);
    setState(() {
      t = tgl2;
      ts = tgl3;
    });
  }

  getsp(iter) async {
    var hasil;
    await Firestore.instance
        .collection("tanaman")
        .where('buah', isEqualTo: datareport[iter].buah)
        .getDocuments()
        .then((value) => hasil = value.documents);
    // print("object");
    // print(datareport[0].tanggaltanam);
    if (hasil.length > 1) {
      for (var m = 0; m < hasil.length; m++) {
        var jsp = hasil[m]['jsp'];
        Timestamp timestamp = hasil[m]['tanggal tanam'];
        var date = DateTime.parse(timestamp.toDate().toString());
        if (date.toString() == datareport[iter].tanggaltanam) {
          if (jsp == 1) {
            for (var k = 0; k < datamonitoring.length; k++) {
              datamonitoring[k].sp = hasil[m]['SP'];
              setState(() {
                z = "";
              });
            }
          } else if (jsp > 1) {
            for (var i = 1; i <= jsp; i++) {
              if (i == i) {
                if (i == 1) {
                  var endloop = hasil[m]['startsp2'];
                  for (var j = 0; j < endloop; j++) {
                    datamonitoring[j].sp = hasil[m]['SP'];
                    // setState(() {
                    //   z = "";
                    // });
                  }
                } else {
                  // var endloop = hasil
                  if (jsp - i == 0) {
                    var start = hasil[m]['startsp' + '$i'];
                    for (var k = start; k < datamonitoring.length; k++) {
                      datamonitoring[k].sp = hasil[m]['sp' + '$i'];
                      setState(() {
                        z = "";
                      });
                    }
                  } else {
                    var next = i + 1;
                    var start = hasil[m]['startsp' + '$i'];
                    var end = hasil[m]['startsp' + '$next'];
                    for (var k = start; k < end; k++) {
                      datamonitoring[k].sp = hasil[m]['sp' + '$i'];
                    }
                  }
                }
              }
            }
          }
        }
      }
    } else if (hasil.length == 1) {
      var jsp = hasil[0]['jsp'];
      // print(jsp);
      if (jsp == 1) {
        for (var i = 0; i < datamonitoring.length; i++) {
          datamonitoring[i].sp = hasil[0]['SP'];
          setState(() {
            z = "";
          });
        }
      } else if (jsp > 1) {
        for (var i = 1; i <= jsp; i++) {
          if (i == i) {
            if (i == 1) {
              var endloop = hasil[0]['startsp2'];
              for (var j = 0; j < endloop; j++) {
                datamonitoring[j].sp = hasil[0]['SP'];
                // setState(() {
                //   z = "";
                // });
              }
            } else {
              // var endloop = hasil
              if (jsp - i == 0) {
                var start = hasil[0]['startsp' + '$i'];
                for (var k = start; k < datamonitoring.length; k++) {
                  datamonitoring[k].sp = hasil[0]['sp' + '$i'];
                  setState(() {
                    z = "";
                  });
                }
              } else {
                var next = i + 1;
                var start = hasil[0]['startsp' + '$i'];
                var end = hasil[0]['startsp' + '$next'];
                for (var k = start; k < end; k++) {
                  datamonitoring[k].sp = hasil[0]['sp' + '$i'];
                }
              }
            }
          }
        }
      }
    }
  }

  getallreport(iter) async {
    datamonitoring.clear();
    var awal = datareport[iter].tanggaltanam;
    var start = DateTime.parse(awal);
    var akhir = datareport[iter].tanggalpanen;
    var end = DateTime.parse(akhir);

    var notes;
    var notes2;
    var notes3;
    var notes4;
    var notes5;

    print(start);
    // print('tgl akhir');
    print(end);

    // var tes =DateTime(start.year, start.month, start.day - 1,23);
    // print(tes);
    var hasil;
    var hasil2;
    var hasil3;
    var hasil4;
    var hasil5;

    //   print(end);
    var cek = jumlahdata[iter];
    // print(cek);
    if (cek != 0) {
      if (cek == 1) {
        await Firestore.instance
            .collection("Sensor")
            .where("tanggal dan waktu",
                isGreaterThanOrEqualTo: start, isLessThan: end)
            .getDocuments()
            .then((value) => hasil = value.documents);
        await Firestore.instance
            .collection("catatan")
            .where("tanggal dan waktu",
                isGreaterThanOrEqualTo: start, isLessThan: end)
            .getDocuments()
            .then((value) => notes = value.documents);
        double ph = 0;
        var lampu = 0;
        var tinggiair = 0;
        var nutrisi = 0;
        // print(hasil2[0]['lampu'] + 3);

        for (var i = 0; i < hasil.length; i++) {
          lampu = lampu + hasil[i]['lampu'];
          nutrisi = nutrisi + hasil[i]['nutrisi'];
          ph = ph + hasil[i]['ph'];
          tinggiair = tinggiair + hasil[i]['tinggi air'];
        }
        var lamp = lampu / hasil.length;
        var vit = nutrisi / hasil.length;
        var phh = ph / hasil.length;
        var tair = tinggiair / hasil.length;
        var hari = DateFormat('d LLL').format(start);
        var waktu = DateFormat('d LLL y').format(start);

        datamonitoring.add(Monitor(
            hari.toString(),
            phh.toString(),
            lamp.toString(),
            vit.toString(),
            waktu.toString(),
            tair.toString(),
            notes.length == 0 ? "Tidak ada catatan" : notes[0]['note'],
            "",
            ""));
      } else if (cek > 1) {
        for (var i = 0; i < cek; i++) {
          if (i == 0) {
            await Firestore.instance
                .collection("Sensor")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo: start,
                    isLessThan:
                        DateTime(start.year, start.month, start.day, 23))
                .getDocuments()
                .then((value) => hasil2 = value.documents);
            await Firestore.instance
                .collection("catatan")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo: start,
                    isLessThan:
                        DateTime(start.year, start.month, start.day, 23))
                .getDocuments()
                .then((value) => notes2 = value.documents);
            double ph = 0;
            var lampu = 0;
            var tinggiair = 0;
            var nutrisi = 0;
            // print(hasil2[0]['lampu'] + 3);

            for (var i = 0; i < hasil2.length; i++) {
              lampu = lampu + hasil2[i]['lampu'];
              nutrisi = nutrisi + hasil2[i]['nutrisi'];
              ph = ph + hasil2[i]['ph'];
              tinggiair = tinggiair + hasil2[i]['tinggi air'];
            }
            var lamp = lampu / hasil2.length;
            var vit = nutrisi / hasil2.length;
            var phh = ph / hasil2.length;
            var tair = tinggiair / hasil2.length;
            var hari = DateFormat('d LLL').format(start);
            var waktu = DateFormat('d LLL y').format(start);
            datamonitoring.add(Monitor(
                hari.toString(),
                phh.toString(),
                lamp.toString(),
                vit.toString(),
                waktu.toString(),
                tair.toString(),
                notes2.length == 0 ? "Tidak ada catatan" : notes2[0]['note'],
                "",
                ""));
          } else if (i != 0 && i != cek - 1 && i != cek - 2) {
            await Firestore.instance
                .collection("Sensor")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(start.year, start.month, start.day + i, 0),
                    isLessThan:
                        DateTime(start.year, start.month, start.day + i, 23))
                .getDocuments()
                .then((value) => hasil3 = value.documents);
            await Firestore.instance
                .collection("catatan")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(start.year, start.month, start.day + i, 0),
                    isLessThan:
                        DateTime(start.year, start.month, start.day + i, 23))
                .getDocuments()
                .then((value) => notes3 = value.documents);
            //  print(hasil.length);
            double ph = 0;
            var lampu = 0;
            var tinggiair = 0;
            var nutrisi = 0;
            // print(hasil2[0]['lampu'] + 3);

            for (var i = 0; i < hasil3.length; i++) {
              lampu = lampu + hasil3[i]['lampu'];
              nutrisi = nutrisi + hasil3[i]['nutrisi'];
              ph = ph + hasil3[i]['ph'];
              tinggiair = tinggiair + hasil3[i]['tinggi air'];
            }
            var lamp = lampu / hasil3.length;
            var vit = nutrisi / hasil3.length;
            var phh = ph / hasil3.length;
            var tair = tinggiair / hasil3.length;
            var harih = DateTime(start.year, start.month, start.day + i);
            var hari = DateFormat('d LLL').format(harih);
            var waktu = DateFormat('d LLL y').format(harih);
            datamonitoring.add(Monitor(
                hari.toString(),
                phh.toString(),
                lamp.toString(),
                vit.toString(),
                waktu.toString(),
                tair.toString(),
                notes3.length == 0 ? "Tidak ada catatan" : notes3[0]['note'],
                "",
                ""));
          } else if (i == cek - 2) {
            await Firestore.instance
                .collection("Sensor")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day - 1, 0),
                    isLessThan: DateTime(end.year, end.month, end.day - 1, 23))
                .getDocuments()
                .then((value) => hasil5 = value.documents);
            await Firestore.instance
                .collection("catatan")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day - 1, 0),
                    isLessThan: DateTime(end.year, end.month, end.day - 1, 23))
                .getDocuments()
                .then((value) => notes5 = value.documents);
            double ph = 0;
            var lampu = 0;
            var tinggiair = 0;
            var nutrisi = 0;
            // print(hasil2[0]['lampu'] + 3);

            for (var i = 0; i < hasil5.length; i++) {
              lampu = lampu + hasil5[i]['lampu'];
              nutrisi = nutrisi + hasil5[i]['nutrisi'];
              ph = ph + hasil5[i]['ph'];
              tinggiair = tinggiair + hasil5[i]['tinggi air'];
            }
            var lamp = lampu / hasil5.length;
            var vit = nutrisi / hasil5.length;
            var phh = ph / hasil5.length;
            var tair = tinggiair / hasil5.length;
            var harih = DateTime(end.year, end.month, end.day - 1);
            var hari = DateFormat('d LLL').format(harih);
            var waktu = DateFormat('d LLL y').format(harih);
            datamonitoring.add(Monitor(
                hari.toString(),
                phh.toString(),
                lamp.toString(),
                vit.toString(),
                waktu.toString(),
                tair.toString(),
                notes5.length == 0 ? "Tidak ada catatan" : notes5[0]['note'],
                "",
                ""));
            // print(999);
            //  print(hasil.length );
          } else if (i == cek - 1) {
            await Firestore.instance
                .collection("Sensor")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day, 0),
                    isLessThan: end)
                .getDocuments()
                .then((value) => hasil4 = value.documents);
            await Firestore.instance
                .collection("catatan")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day, 0),
                    isLessThan: end)
                .getDocuments()
                .then((value) => notes4 = value.documents);
            double ph = 0;
            var lampu = 0;
            var tinggiair = 0;
            var nutrisi = 0;
            // print(hasil2[0]['lampu'] + 3);

            for (var i = 0; i < hasil4.length; i++) {
              lampu = lampu + hasil4[i]['lampu'];
              nutrisi = nutrisi + hasil4[i]['nutrisi'];
              ph = ph + hasil4[i]['ph'];
              tinggiair = tinggiair + hasil4[i]['tinggi air'];
            }
            var lamp = lampu / hasil4.length;
            var vit = nutrisi / hasil4.length;
            var phh = ph / hasil4.length;
            var tair = tinggiair / hasil4.length;
            var harih = DateTime(end.year, end.month, end.day);
            var hari = DateFormat('d LLL').format(harih);
            var waktu = DateFormat('d LLL y').format(harih);
            datamonitoring.add(Monitor(
                hari.toString(),
                phh.toString(),
                lamp.toString(),
                vit.toString(),
                waktu.toString(),
                tair.toString(),
                notes4.length == 0 ? "Tidak ada catatan" : notes4[0]['note'],
                "",
                ""));
            // print(999);
            //  print(hasil.length );
          }
        }
      }

      // print(notes[0]['note']);
      // print(datamonitoring.length);
      // Timestamp timestamp = hasil[47]['tanggal dan waktu'];
      // var date = DateTime.parse(timestamp.toDate().toString());

    }
  }

  @override
  void initState() {
    gettime();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset("assets/Rectangle 45 (1).svg")),
          Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset("assets/Rectangle 44.svg")),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.width * 0.05,
                        color: Color.fromRGBO(0, 0, 0, 0.54),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.18),
                      child: Text(
                        "LATEST REPORT",
                        style: TextStyle(
                            color: Color.fromRGBO(198, 198, 198, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ts,
                      style: TextStyle(
                          color: Color.fromRGBO(82, 82, 82, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.005),
                    child: Text(
                      t,
                      // "User",
                      style: TextStyle(
                          color: Color.fromRGBO(183, 183, 183, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.0380),
                    ),
                  ),
                ),
                Expanded(
                  // width:  MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height *0.6
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          z = index;
                                        });
                                        await getallreport(index);
                                        await getsp(index);
                                        ke = index;

                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    Detailmonitoring()));
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0, 5))
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: z == index
                                                  ? CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              color[index]))
                                                  : Text(
                                                      datareport[index].buah,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Inter normal',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          color: color[index]),
                                                    )),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: MediaQuery.of(context)
                                                .size
                                                .width -
                                            MediaQuery.of(context).size.width *
                                                1.07,
                                        top: MediaQuery.of(context).size.width -
                                            MediaQuery.of(context).size.width *
                                                0.98,
                                        child: SvgPicture.asset(
                                          foto[index],
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                        )),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width *
                                              0.37,
                                      top: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width *
                                              0.94,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            jumlahdata[index].toString(),
                                            style: TextStyle(
                                                fontFamily: 'Inter normal',
                                                fontWeight: FontWeight.w800,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                color: color[index]),
                                          ),
                                          Text(
                                            "report",
                                            style: TextStyle(
                                                fontFamily: 'Inter normal',
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.034,
                                                color: Colors.grey[400]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                      itemCount: datareport.length,
                      physics: ClampingScrollPhysics(),
                    ),
                  ),
                ),
//

//               Padding(
//                 padding:  EdgeInsets.only(top : 10.0,left: MediaQuery.of(context).size.width * 0.1),
//                 child: Align(
// alignment: Alignment.centerLeft,
//                                   child: Stack(
//                        overflow: Overflow.visible,
//                        children: <Widget>[
//                          InkWell(
//                            onTap: (){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>Detailmonitoring()));},
//                                                     child: Container(
//                              height: MediaQuery.of(context).size.width * 0.2  ,width: MediaQuery.of(context).size.width * 0.6,decoration: BoxDecoration(
//                                borderRadius: BorderRadius.all(Radius.circular(10)),
//                                color: Colors.white,
//                                boxShadow: [BoxShadow(
// blurRadius: 5.0,
//           color: Colors.black12,
//           spreadRadius: 3.0,
//           offset: Offset(0, 5)
//                                )]
//                              ),child: Padding(
//                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.12),
//                                child: Align(
//                                  alignment: Alignment.centerLeft,
//                                  child: Text("Orange",style: TextStyle(fontFamily: 'Inter normal',fontWeight: FontWeight.w800,fontSize: MediaQuery.of(context).size.width * 0.04,color: Colors.orange),)),
//                              ),
//                            ),
//                          ),
//                          Positioned(
//                            left: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 1.07,top: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.98,
//                            child: SvgPicture.asset("assets/orange.svg",height: MediaQuery.of(context).size.width * 0.15,width: MediaQuery.of(context).size.width * 0.15,))
//                            ,Positioned(
//                              left: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.37,top: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.94,
//                                                        child: Column(
//                                children: <Widget>[
//                                  Text("30",style: TextStyle(fontFamily: 'Inter normal',fontWeight: FontWeight.w800,fontSize: MediaQuery.of(context).size.width * 0.04,color: Colors.orange),)
//                                  , Text("report",style: TextStyle(fontFamily: 'Inter normal',fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width * 0.034,color: Colors.grey[400]),)
//                                ],
//                              ),
//                            )
//                        ],
//                      ),
//                 ),
//               )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
