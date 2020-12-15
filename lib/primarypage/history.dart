import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/primarypage/subpage/detailmonitoring.dart';
import 'package:hydroponic/primarypage/subpage/export.dart';
import 'package:hydroponic/primarypage/subpage/listreport.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hydroponic/list/list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
// import 'package:date_format/date_format.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // var x ="Tomato";
  var cek = 0;
  var r = 4;
  var ctime;
  var t = DateFormat('EEEE').format(DateTime.now());
  var ts = DateFormat('d LLL y').format(DateTime.now());

  int lx;

  gettime() {
    var tgl = DateTime.now();
    var tgl2 = DateFormat('EEEE').format(tgl);
    var tgl3 = DateFormat('d LLL y').format(tgl);
    setState(() {
      t = tgl2;
      ts = tgl3;
    });
  }

  next() {
    print(segmen);
    print(at);
    // print(loop1);
    if (segmen == 1)
      _showDialog("Information", "anda sudah berada pada halaman terakhir");
    else {
      if (segmen == 2 && at == 1) {
        at = 2;
        tampildata(loop1, loop1 + loop2);
      } else if (segmen == 3 && at == 1) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 3 && at == 2) {
        at = 3;
        tampildata(loop1 + loop3, loop1 + loop3 + loop4);
      } else if (segmen == 4 && at == 1) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 4 && at == 2) {
        at = 3;
        tampildata(loop1 + loop3, loop1 + loop3 + loop5);
      } else if (segmen == 4 && at == 3) {
        at = 4;
        tampildata(loop1 + loop3 + loop5, loop1 + loop3 + loop5 + loop6);
      } else if (segmen == 5 && at == 1) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 5 && at == 2) {
        at = 3;
        tampildata(loop1 + loop3, loop1 + loop3 + loop5);
      } else if (segmen == 5 && at == 3) {
        at = 4;
        tampildata(loop1 + loop3 + loop5, loop1 + loop3 + loop5 + loop7);
      } else if (segmen == 5 && at == 4) {
        at = 5;
        tampildata(loop1 + loop3 + loop5 + loop7,
            loop1 + loop3 + loop5 + loop7 + loop8);
      } else if (segmen == 2 && at == 2)
        _showDialog("Information", "anda sudah berada pada halaman terakhir");
      else if (segmen == 3 && at == 3)
        _showDialog("Information", "anda sudah berada pada halaman terakhir");
      else if (segmen == 4 && at == 4)
        _showDialog("Information", "anda sudah berada pada halaman terakhir");
      else if (segmen == 5 && at == 5)
        _showDialog("Information", "anda sudah berada pada halaman terakhir");
    }
  }

  back() {
    if (segmen == 1)
      _showDialog("Information", "anda sudah berada pada halaman terakhir");
    else {
      if (at == 1)
        _showDialog("Information", "anda sudah berada pada halaman terakhir");
      else if (segmen == 2 && at == 2) {
        at = 1;
        tampildata(0, loop1);
      } else if (segmen == 3 && at == 2) {
        at = 1;
        tampildata(0, loop1);
      } else if (segmen == 3 && at == 3) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 4 && at == 2) {
        at = 1;
        tampildata(0, loop1);
      } else if (segmen == 4 && at == 3) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 4 && at == 4) {
        at = 3;
        tampildata(loop1 + loop3, loop1 + loop3 + loop5);
      } else if (segmen == 5 && at == 2) {
        at = 1;
        tampildata(0, loop1);
      } else if (segmen == 5 && at == 3) {
        at = 2;
        tampildata(loop1, loop1 + loop3);
      } else if (segmen == 5 && at == 4) {
        at = 3;
        tampildata(loop1 + loop3, loop1 + loop3 + loop5);
      } else if (segmen == 5 && at == 5) {
        at = 4;
        tampildata(loop1 + loop3 + loop5, loop1 + loop3 + loop5 + loop7);
      }
    }
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
    // await Firestore.instance.collection('activity').document().setData({
    //   "by": profil[0].email,
    //   "jenis": "tambah",
    //   "pesan": customdetail[0].nama,
    //   "tanggal": Timestamp.fromMillisecondsSinceEpoch(
    //       DateTime.now().millisecondsSinceEpoch)
    // });
    // getnotif();
    // setState(() {
    // isLoading = 0;
    // });
    // _showDialog(
    //     "Information", "Success to change, let's check your home screen");
  }

  // getfruitty() async {
  //   // ceks.add(1);
  //   foto.clear();
  //   color.clear();
  //   datareport.clear();
  //   jumlahdata.clear();
  //   var val;
  //   await Firestore.instance
  //       .collection('tanaman')
  //       .orderBy("tanggal tanam", descending: true)
  //       .getDocuments()
  //       .then((value) => val = value.documents);
  //   // print(val.length);

  //   // print("belum ada buah");
  //   if (val.length != 0) {
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

  segment(length) {
    // var length;
    if (length < 8) {
      tampildata(0, length);
      segmen = 1;
      at = 1;
      print("$length" + " hasil " + '$length');
    } else {
      segmen = int.parse((length / 5).toStringAsFixed(0));
      loop1 = int.parse((length / segmen).toStringAsFixed(0));
      loop2 = length - loop1;
      loop3 = int.parse((loop2 / (loop2 / loop1)).toStringAsFixed(0));
      if (loop2 < 7) {
        at = 1;
        segmen = 2;
        tampildata(0, loop1);
        print("$length" + " hasil " + '$loop1' + ' $loop2');
      } else if (loop2 > 7) {
        loop4 = loop2 - loop3;
        loop5 = loop4 - (loop4 - loop3);
        loop6 = length - (loop1 + loop3 + loop5);
        if (loop4 < 7) {
          at = 1;
          segmen = 3;
          tampildata(0, loop1);
          print("$length" + " hasil " + "$loop1" + ' $loop3' + ' $loop4');
        } else if (loop4 > 7) {
          if (loop6 < 7) {
            at = 1;
            segmen = 4;
            tampildata(0, loop1);
            print("$length" +
                " hasil " +
                "$loop1" +
                ' $loop3' +
                ' $loop5' +
                ' $loop6');
          } else if (loop6 > 7) {
            loop7 = loop6 - (loop6 - loop5);
            loop8 = loop6 - loop7;
            at = 1;
            segmen = 5;
            tampildata(0, loop1);
            print("$length" +
                " hasil " +
                "$loop1" +
                ' $loop3' +
                ' $loop5' +
                ' $loop7' +
                ' $loop8');
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
    print(cek);
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

  fruit(buah, foto, warna, jumlah, iter) {
    // getfruit();
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () async {
            setState(() {
              r = iter;
            });
            ke = iter;

            await getallreport(iter);
            await getsp(iter);

            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => Detailmonitoring()));
          },
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      left: MediaQuery.of(context).size.width * 0.12),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: r == iter
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(warna))
                          : Text(
                              buah,
                              style: TextStyle(
                                  fontFamily: 'Inter normal',
                                  fontWeight: FontWeight.w800,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: warna),
                            )),
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 1.07,
                  top: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 0.98,
                  child: SvgPicture.asset(
                    foto,
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                  )),
              Positioned(
                left: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.46,
                top: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.94,
                child: Column(
                  children: <Widget>[
                    Text(
                      jumlah,
                      style: TextStyle(
                          fontFamily: 'Inter normal',
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: warna),
                    ),
                    Text(
                      "report",
                      style: TextStyle(
                          fontFamily: 'Inter normal',
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.034,
                          color: Colors.grey[400]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
        ),
      ],
    );
  }

  tampildata(awal, iter) {
    databar1.clear();
    databar2.clear();
    databar3.clear();
    databar4.clear();
    for (var i = awal; i < iter; i++) {
      Timestamp timestamp = datagrafik[i]['tanggal dan waktu'];
      var date = DateTime.parse(timestamp.toDate().toString());
      var tgl = formatDate(
        date,
        ['HH', ':', 'nn'],
      );
      databar1.add(Stacked(tgl.toString(), datagrafik[i]['lampu'],
          Color.fromRGBO(96, 168, 90, 1)));
      databar2.add(Stacked(tgl.toString(), datagrafik[i]['tinggi air'],
          Color.fromRGBO(130, 255, 119, 1)));
      databar3.add(Stacked(tgl.toString(), datagrafik[i]['nutrisi'],
          Color.fromRGBO(52, 104, 67, 1)));
      databar4.add(Stacked(tgl.toString(), datagrafik[i]['ph'],
          Color.fromRGBO(135, 173, 70, 0.62)));
    }
    setState(() {});
  }

  getdata(time) async {
    DateTime start = DateTime.parse(time + ' 00:00');
    DateTime end = DateTime.parse(time + ' 23:59');
    print(start);
    // print(notes[0]['tanggal dan waktu']);
    // Timestamp timestamp = notes[0]['tanggal dan waktu'];
    // var date = DateTime.parse(timestamp.toDate().toString());
    //   print('$date' + 'ini');
    // if (time.toString() == notes[0]['tanggal dan waktu'].toString())
    // print("sama");

    //  print(todayDate);
    //  print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    await Firestore.instance
        .collection("Sensor")
        .where("tanggal dan waktu",
            isGreaterThanOrEqualTo: start, isLessThan: end)
        .getDocuments()
        .then((value) => datagrafik = value.documents);
    if (datagrafik.length == 0) {
      databar1.clear();
      databar2.clear();
      databar3.clear();
      databar4.clear();
      setState(() {});
      _showDialog("Information", "Belum ada data");
    } else if (datagrafik.length != 0) segment(datagrafik.length);
    // var time = timeago.format(waktu);
    // Timestamp timestamp = datas;
    // if (datas.length > 7 ){
    // var math = (10 / 5  ).floor();
//  var date = DateTime.parse(timestamp.toDate().toString());
    // var date = new DateTime.fromMillisecondsSinceEpoch(waktu * 1000);
    // print(formatDate(date, ['HH',':','nn'],));
    // print(timeago.format(DateTime.tryParse(timestamp.toDate().toString())));//jika mau mendapatkan log
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
                r = 4;
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
                        r = 4;
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
            r = 4;
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
                    r = 4;
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

  selection() {
    datafiltered.clear();
    if (datareport.length != 0) {
      for (var k = 0; k < datareport.length; k++) {
        datafiltered.add(Reportz(datareport[k].buah, datareport[k].tanggaltanam,
            datareport[k].tanggalpanen));
      }
      for (var i = 0; i < datareport.length; i++) {
        for (var j = i + 1; j < datareport.length; j++) {
          // print(i);
          if (datareport[i].buah == datareport[j].buah) {
            // print("sama");
            datafiltered[j].buah = 'hapus';
          }
        }
      }
      // print("object");
      setState(() {});
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Export()));
    }
  }

  // selection() {
  //   datafilter.clear();
  //   // for(var k = 0 ; k < datareport.length; k++){
  //   //   if ( )

  //   // }

  // }

  @override
  void initState() {
    // getdata();
    // gettime();
    // ceks.length == 0 ? getfruit() : print("masuk");

    // getfruit();
    // print("oi");
    // databar1.clear();
    // databar2.clear();
    // databar3.clear();
    // databar4.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series(
        domainFn: (Stacked stack, _) => stack.waktu,
        measureFn: (Stacked stack, _) => stack.value,
        colorFn: (Stacked stack, _) =>
            charts.ColorUtil.fromDartColor(stack.colorval),
        id: 'pH',
        data: databar4,
        labelAccessorFn: (Stacked row, _) => "${row.value.toString()}",
      ),
      charts.Series(
        domainFn: (Stacked stack, _) => stack.waktu,
        measureFn: (Stacked stack, _) => stack.value,
        colorFn: (Stacked stack, _) =>
            charts.ColorUtil.fromDartColor(stack.colorval),
        id: 'Nutrisi',
        data: databar3,
        labelAccessorFn: (Stacked row, _) => "${row.value.toString()}",
      ),
      charts.Series(
        domainFn: (Stacked stack, _) => stack.waktu,
        measureFn: (Stacked stack, _) => stack.value,
        colorFn: (Stacked stack, _) =>
            charts.ColorUtil.fromDartColor(stack.colorval),
        id: 'Air',
        data: databar2,
        labelAccessorFn: (Stacked row, _) => "${row.value.toString()}",
      ),
      charts.Series(
        domainFn: (Stacked stack, _) => stack.waktu,
        measureFn: (Stacked stack, _) => stack.value,
        colorFn: (Stacked stack, _) =>
            charts.ColorUtil.fromDartColor(stack.colorval),
        id: 'Lampu',
        data: databar1,
        labelAccessorFn: (Stacked row, _) => "${row.value.toString()}",
      )
    ];

    // var m = 1;

    var chart = charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      behaviors: [
        new charts.SeriesLegend(
            defaultHiddenSeries: hide == 4
                ? []
                : hide == 3
                    ? ['Air', 'Nutrisi', 'pH']
                    : hide == 2
                        ? ['Lampu', 'Nutrisi', 'pH']
                        : hide == 1
                            ? ['Air', 'Lampu', 'Nutrisi']
                            : hide == 0
                                ? ['Air', 'Lampu', 'pH']
                                : []),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.7,
                  // left: MediaQuery.of(context).size.width *
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        next();
                      },
                      child: SvgPicture.asset(
                        "assets/Group 54.svg",
                        height: MediaQuery.of(context).size.width * 0.12,
                        width: MediaQuery.of(context).size.width * 0.12,
                      )
                      // Group 53.svg
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.7,
                  // left: MediaQuery.of(context).size.width *
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () {
                        back();
                      },
                      child: SvgPicture.asset(
                        "assets/Group 53.svg",
                        height: MediaQuery.of(context).size.width * 0.12,
                        width: MediaQuery.of(context).size.width * 0.12,
                      )
                      //
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.3),
                child: Row(
                  children: <Widget>[
                    Text(
                      "MONITORING HISTORY",
                      style: TextStyle(
                          color: Color.fromRGBO(198, 198, 198, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.034,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(),
                    //   child: InkWell(
                    //     // onTap: (){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>StackedBarChart()));},
                    //     child: Text(
                    //       "INFO",
                    //       style: TextStyle(
                    //           color: Color.fromRGBO(111, 229, 123, 1),
                    //           fontSize: MediaQuery.of(context).size.width * 0.034,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        top: MediaQuery.of(context).size.width * 0.2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t,
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
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.005),
                      child: Text(
                        ts,
                        // "User",
                        style: TextStyle(
                            color: Color.fromRGBO(183, 183, 183, 1),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.0380),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        top: MediaQuery.of(context).size.width * 0.025),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width * 0.75,
                            width: MediaQuery.of(context).size.width * 0.8,
                            color: Colors.white,
                            child: chart,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.21,
                    left: MediaQuery.of(context).size.width * 0.7),
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100))
                        .then((date) {
                      setState(() {
                        ctime = DateFormat('yyyy-MM-dd').format(date);
                        //  print(ctime);
                        t = DateFormat('EEEE').format(date);
                        ts = DateFormat('d LLL y').format(date);
                        getdata(ctime);
                        //  _dateTime = date;
                      });
                    });
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.width * 0.08,
                      width: MediaQuery.of(context).size.width * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.black12,
                                spreadRadius: 3.0,
                                offset: Offset(0, 5))
                          ]),
                      child: IconButton(
                          icon: Icon(
                            Icons.settings_input_component,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                          onPressed: null)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.21,
                    left: MediaQuery.of(context).size.width * 0.82),
                child: Container(
                    height: MediaQuery.of(context).size.width * 0.08,
                    width: MediaQuery.of(context).size.width * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 3.0,
                              offset: Offset(0, 5))
                        ]),
                    child: IconButton(
                      icon: Icon(
                        MdiIcons.fileOutline,
                        color: Colors.green,
                        size: MediaQuery.of(context).size.width * 0.04,
                      ),
                      onPressed: () {
                        selection();
                      },
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 1.15,
                    left: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.width * 0.03),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Latest Report",
                      style: TextStyle(
                          color: Color.fromRGBO(82, 82, 82, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Inter normal'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.35),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            lx = 0;
                          });

                          await getfruit();
                          setState(() {
                            lx = 1;
                          });
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => Listreport()));
                        },
                        child: lx == 0
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(111, 229, 123, 1),
                              ))
                            : Text(
                                "See all",
                                style: TextStyle(
                                    color: Color.fromRGBO(111, 229, 123, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.034,
                                    fontWeight: FontWeight.w700),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),

            // if()
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                      child: fruit(datareport[index].buah, foto[index],
                          color[index], jumlahdata[index].toString(), index)),
                );
              },
              itemCount: datareport.length < 3 ? datareport.length : 3,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }
}
