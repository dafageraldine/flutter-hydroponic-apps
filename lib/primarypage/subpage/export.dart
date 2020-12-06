import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:hydroponic/list/list.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

class Export extends StatefulWidget {
  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  var ts = "";
  var ts2 = "";
  var awal;
  var akhir;
  var load = 0;
  var buahs = "";

// ignore: unused_element
  void _showDialog(judul, konten) {
    // flutter defined function
    showDialog(
      context: this.context,
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

  req() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      // req();
      // print(status.isGranted);
    }
    if (status.isGranted) {
      getallreport();
    }
  }

  gettime() {
    var tgl = DateTime.now();
    var tgl2 = DateFormat('d LLL y').format(tgl);
    var tgl3 = DateTime(tgl.year, tgl.month, tgl.day - 1);
    var tgl4 = DateFormat('d LLL y').format(tgl3);
    var tgl5 = DateTime(tgl.year, tgl.month, tgl.day + 1);
    setState(() {
      ts2 = tgl2;
      ts = tgl4;
      //  awal = DateFormat('yyyy-MM-dd').format(date);
      awal = DateFormat('yyyy-MM-dd').format(tgl3);
      print(awal);
      akhir = DateFormat('yyyy-MM-dd').format(tgl5);
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/datamonitoring.xlsx');
  }

  Future<int> excel() async {
    try {
      ByteData data = await rootBundle.load("assets/datamonitoring.xlsx");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      // print(decoder);

      // for (var table in decoder.tables.keys) {
      //   // print(table);
      //   // print(decoder.tables[table].maxCols);
      //   // print(decoder.tables[table].maxRows);
      //   for (var row in decoder.tables[table].rows) {
      //     print('$row');
      //   }
      // }
      var sheet = decoder.tables.keys.first;
      for (var i = 0; i < datamonitoring.length; i++) {
        decoder
// ..updateCell(sheet, 0, 3, 1);
          ..insertRow(sheet, i + 2)
          ..updateCell(sheet, 0, i + 2, i + 1) //No
          ..updateCell(
              sheet, 1, i + 2, datamonitoring[i].tahun.toString()) //Tanggal
          ..updateCell(sheet, 2, i + 2, datamonitoring[i].buah) //Tanaman
          ..updateCell(sheet, 3, i + 2, datamonitoring[i].sp) //nama setpoint
          ..updateCell(sheet, 4, i + 2, datamonitoring[i].nutrisi) //nutrisi
          ..updateCell(sheet, 5, i + 2, datamonitoring[i].air) //ketinggian air
          ..updateCell(sheet, 6, i + 2, datamonitoring[i].ph) //ph
          ..updateCell(sheet, 7, i + 2, datamonitoring[i].lampu) //lampu
          ..updateCell(sheet, 8, i + 2, datamonitoring[i].catatan); //catatan
      }
      Directory appDocDirectory = await getExternalStorageDirectory();

      new Directory(appDocDirectory.path + '/').create(recursive: true)
// The created directory is returned as a Future.
          .then((Directory directory) {
        print('Path of New Dir: ' + directory.path);
      });

      File(join(
          '/storage/emulated/0/hidroponik exported excel/${basename("assets/datamonitoring.xlsx")}'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(decoder.encode());
      load = 0;
      getnotif();
      _showDialog("Export success",
          "open your file on hidroponik exported excel folder");
      setState(() {});
      print(sheet);
    } catch (e) {
      print(e);
      // If encountering an error, return 0.
      return 0;
    }
  }

  Future getnotif() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    try {
      http.Response cek = await http
          .get(linkApi + "send_notifications_exportberhasil/" + "$playerId");
    } catch (e) {}
  }

  Future<int> excelf() async {
    try {
      ByteData data = await rootBundle.load("assets/datamonitoring.xlsx");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      // print(decoder);

      // for (var table in decoder.tables.keys) {
      //   // print(table);
      //   // print(decoder.tables[table].maxCols);
      //   // print(decoder.tables[table].maxRows);
      //   for (var row in decoder.tables[table].rows) {
      //     print('$row');
      //   }
      // }
      var sheet = decoder.tables.keys.first;
      for (var i = 0; i < filtered.length; i++) {
        decoder
// ..updateCell(sheet, 0, 3, 1);
          ..insertRow(sheet, i + 2)
          ..updateCell(sheet, 0, i + 2, i + 1) //No
          ..updateCell(sheet, 1, i + 2, filtered[i].tahun) //Tanggal
          ..updateCell(sheet, 2, i + 2, filtered[i].buah) //Tanaman
          ..updateCell(sheet, 3, i + 2, filtered[i].sp) //nama setpoint
          ..updateCell(sheet, 4, i + 2, filtered[i].nutrisi) //nutrisi
          ..updateCell(sheet, 5, i + 2, filtered[i].air) //ketinggian air
          ..updateCell(sheet, 6, i + 2, filtered[i].ph) //ph
          ..updateCell(sheet, 7, i + 2, filtered[i].lampu) //lampu
          ..updateCell(sheet, 8, i + 2, filtered[i].catatan); //catatan
      }
      Directory appDocDirectory = await getExternalStorageDirectory();

      new Directory(appDocDirectory.path + '/').create(recursive: true)
// The created directory is returned as a Future.
          .then((Directory directory) {
        print('Path of New Dir: ' + directory.path);
      });

      File(join(
          '/storage/emulated/0/hidroponik exported excel/${basename("assets/datamonitoring.xlsx")}'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(decoder.encode());
      load = 0;
      filtered.clear();
      await getnotif();
      _showDialog("Export success",
          "open your file on hidroponik exported excel folder");
      setState(() {});
      // print(sheet);
    } catch (e) {
      // print(e);
      filtered.clear();
      // If encountering an error, return 0.
      return 0;
    }
  }

  buah1() async {
    excelbuah.clear();
    select.clear();
    // datamonitoring.add(Monitor("tanggal", "ph", "lampu", "nutrisi", "tahun", "air", "catatan", "buah"));
    // datamonitoring.add(Monitor("tanggal", "ph", "lampu", "nutrisi", "tahun", "air", "catatan", "buah1"));
    // datamonitoring.add(Monitor("tanggal", "ph", "lampu", "nutrisi", "tahun", "air", "catatan", "buah2"));
    DateTime panenkecil = DateTime.parse(awal + ' 00:00');
    DateTime panenbesar = DateTime.parse(akhir + ' 00:00');
    var tgl = DateTime(panenkecil.year, panenkecil.month, panenkecil.day);
    var tgl2 = DateTime(panenbesar.year, panenbesar.month, panenbesar.day - 1);
    var buah;
    // print(tgl2);
    await Firestore.instance
        .collection("tanaman")
        .getDocuments()
        .then((value) => buah = value.documents);

    for (var i = 0; i < buah.length; i++) {
      if (buah[i]['tanggal panen'] != "") {
        Timestamp timestamps = buah[i]['tanggal panen'];
        var date2 = DateTime.parse(timestamps.toDate().toString());
        var convert = DateTime(date2.year, date2.month, date2.day);
        // print(buah[i]['buah']);
        Timestamp times = buah[i]['tanggal tanam'];
        var dates = DateTime.parse(times.toDate().toString());
        var converts = DateTime(dates.year, dates.month, dates.day);

        var differences = converts.difference(tgl).inDays;
        var diffs = tgl2.difference(converts).inDays;

        var difference = convert.difference(tgl).inDays;
        var diff = tgl2.difference(convert).inDays;

        print(buah[i]['buah']);
        print(diff);
        print(difference);
        print(differences);
        print(diffs);
        var pb;
        var pk;
        var tk;
        var tb;
        if (diff < 0) {
          pb = "Null";
        } else if (diff >= 0) {
          pb = diff;
        }
        if (difference < 0) {
          pk = "Null";
        } else if (difference >= 0) {
          pk = difference;
        }
        if (diffs < 0) {
          tb = "Null";
        } else if (diffs >= 0) {
          tb = diffs;
        }
        if (differences < 0) {
          tk = "Null";
        } else if (differences >= 0) {
          tk = differences;
        }
        excelbuah.add(Excelbuah(
            buah[i]['buah'],
            pk.toString(),
            pb.toString(),
            tk.toString(),
            tb.toString(),
            differences.toString(),
            difference.toString(),
            diff.toString(),
            times));
        //  print(excelbuah[i].buah);
        //   print(differences);
        //   print(diffs);
        //   print(difference);
        //   print(diff);
      } else if (buah[i]['tanggal panen'] == "") {
        var waktu = Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch);
        var date = DateTime.parse(waktu.toDate().toString());
        var datec = DateTime(date.year, date.month, date.day);
        var difference = datec.difference(tgl).inDays;
        var diff = tgl2.difference(datec).inDays;
        Timestamp times = buah[i]['tanggal tanam'];
        var dates = DateTime.parse(times.toDate().toString());
        var converts = DateTime(dates.year, dates.month, dates.day);

        var differences = converts.difference(tgl).inDays;
        var diffs = tgl2.difference(converts).inDays;
        print("*****************************");
        print(buah[i]['buah']);
        print(diff);
        print(difference);
        print(differences);
        print(diffs);
        print("*****************************");
        // print(diff);
        var pb;
        var pk;
        var tk;
        var tb;
        if (diff < 0) {
          pb = "Null";
        } else if (diff >= 0) {
          pb = diff;
        }
        if (difference < 0) {
          pk = "Null";
        } else if (difference >= 0) {
          pk = difference;
        }
        if (diffs < 0) {
          tb = "Null";
        } else if (diffs >= 0) {
          tb = diffs;
        }
        if (differences < 0) {
          tk = "Null";
        } else if (differences >= 0) {
          tk = differences;
        }
        excelbuah.add(Excelbuah(
            buah[i]['buah'],
            pk.toString(),
            pb.toString(),
            tk.toString(),
            tb.toString(),
            differences.toString(),
            difference.toString(),
            diff.toString(),
            times));
        // excelbuah.add(Excelbuah(buah[i]['buah'],pk.toString(),pb.toString()));
        // print(excelbuah[i].buah);
        // print(differences);
        // print(diff);
      }
    }

    for (var i = 0; i < buah.length; i++) {
      if (excelbuah[i].panenkecil != 'Null' &&
          excelbuah[i].panenbesar != 'Null') {
        // print("object1");
        // print(excelbuah[i].buah);
        select.add(Selected(excelbuah[i].buah, excelbuah[i].tkecil,
            excelbuah[i].pkecil, excelbuah[i].pbesar, excelbuah[i].waktu));
        // print("object1");
      } else if (excelbuah[i].tanamkecil != 'Null' &&
          excelbuah[i].tanambesar != 'Null') {
        // print("object");
        select.add(Selected(excelbuah[i].buah, excelbuah[i].tkecil,
            excelbuah[i].pkecil, excelbuah[i].pbesar, excelbuah[i].waktu));
        // print("object");
      } else if (excelbuah[i].tanamkecil == 'Null' &&
          excelbuah[i].panenkecil != 'Null') {
        // print("object");
        select.add(Selected(excelbuah[i].buah, excelbuah[i].tkecil,
            excelbuah[i].pkecil, excelbuah[i].pbesar, excelbuah[i].waktu));
        // print("object");
      }
    }
    for (var i = 0; i < select.length; i++) {
      // print(select[i].buah); //<== is desc change to ascend first
      // print(select[i].tk);
      // print(select[i].pk);
      // print(select[i].pb);
      //////////////////////////////////////////////
      //firstfixxxx////////////////////////////////
      ////////////////////////////////////////////
      if (select[i].tk.contains('-') == true &&
          select[i].pb.contains('-') == false) {
        // print(select[i].pb + ' haloo');
        var loop = int.parse(select[i].pk);
        var valuess;
        await Firestore.instance
            .collection('tanaman')
            .where('tanggal tanam', isEqualTo: select[i].waktu)
            .getDocuments()
            .then((value) => valuess = value.documents);
        print("{}{{{}{}{}{}{}{}{}{}");
        print(valuess[0]['buah']);
        print(loop);
        // print(start);
        print("////////////////");
        var jsp = valuess[0]['jsp'];
        if (jsp == 1) {
          for (var j = 0; j <= loop; j++) {
            // print('$j isi');
            if (datamonitoring[j].buah != "") {
              var buaha = datamonitoring[j].buah;
              var buahb = select[i].buah;
              var spa = datamonitoring[j].sp;
              var spb = valuess[0]['SP'];
              datamonitoring[j].sp = '$spa & $spb';
              datamonitoring[j].buah = '$buaha & $buahb';
            } else if (datamonitoring[j].buah == "") {
              datamonitoring[j].sp = valuess[0]['SP'];
              datamonitoring[j].buah = select[i].buah;
            }
          }
        } else if (jsp > 1) {
          if (loop == 0) {
            for (var j = 0; j <= loop; j++) {
              // print('$j isiiii');
              if (datamonitoring[j].buah != "") {
                var buaha = datamonitoring[j].buah;
                var buahb = select[i].buah;
                var spa = datamonitoring[j].sp;
                var spb = valuess[0]['sp$jsp'];
                datamonitoring[j].sp = '$spa & $spb';
                datamonitoring[j].buah = '$buaha & $buahb';
              } else if (datamonitoring[j].buah == "") {
                datamonitoring[j].sp = valuess[0]['sp$jsp'];
                datamonitoring[j].buah = select[i].buah;
              }
            }
          } else if (loop > 0) {
            for (var c = 1; c <= jsp; c++) {
              if (c == 1) {
                var cek =
                    (valuess[0]['startsp2'] - 1 + int.parse(select[i].tk));
                if (cek >= 0) {
                  for (var j = 0; j <= cek; j++) {
                    // print('$j isiw');
                    if (datamonitoring[j].buah != "") {
                      var buaha = datamonitoring[j].buah;
                      var buahb = select[i].buah;
                      var spa = datamonitoring[j].sp;
                      var spb = valuess[0]['SP'];
                      datamonitoring[j].sp = '$spa & $spb';
                      datamonitoring[j].buah = '$buaha & $buahb';
                    } else if (datamonitoring[j].buah == "") {
                      datamonitoring[j].sp = valuess[0]['SP'];
                      datamonitoring[j].buah = select[i].buah;
                    }
                  }
                }
              } else if (c > 1) {
                var next = c + 1;
                var cek = valuess[0]['startsp$next'] == null
                    ? loop
                    : (valuess[0]['startsp$next'] - 1) +
                        int.parse(select[i].tk);
                var starts =
                    (valuess[0]['startsp$c'] + int.parse(select[i].tk)) < 0
                        ? 0
                        : (valuess[0]['startsp$c'] + int.parse(select[i].tk));
                if (cek >= 0) {
                  for (var j = starts; j <= cek; j++) {
                    // print('$j isikkk');
                    if (datamonitoring[j].buah != "") {
                      var buaha = datamonitoring[j].buah;
                      var buahb = select[i].buah;
                      var spa = datamonitoring[j].sp;
                      var spb = valuess[0]['sp$c'];
                      datamonitoring[j].sp = '$spa & $spb';
                      datamonitoring[j].buah = '$buaha & $buahb';
                    } else if (datamonitoring[j].buah == "") {
                      datamonitoring[j].sp = valuess[0]['sp$c'];
                      datamonitoring[j].buah = select[i].buah;
                    }
                  }
                }
              }
            }
          }
        }
      }
      ////////////////////////////////////////////////////////
      //endfirstfixxxx///////////////////////////////////////
      //////////////////////////////////////////////////////
      /////////////////////////////////////////////////////
      //secondfixx////////////////////////////////////////
      ///////////////////////////////////////////////////
      else if (select[i].pb.contains('-') == true &&
          select[i].tk.contains('-') == false) {
        var kurang = int.parse(select[i].pb);
        // print('$kurang kurang bosss');
        var pk = int.parse(select[i].pk);
        var loop = pk + kurang;
        var start = int.parse(select[i].tk);
        var valuess;
        await Firestore.instance
            .collection('tanaman')
            .where('tanggal tanam', isEqualTo: select[i].waktu)
            .getDocuments()
            .then((value) => valuess = value.documents);
        print("++++++++++++++++++");
        print(valuess[0]['buah']);
        print(loop);
        print(start);
        print("////////////////");
        // print(valuess[0]['buah']);
        print('$loop loop');
        print('$start start');
        var jsp = valuess[0]['jsp'];
        if (jsp == 1) {
          for (var j = start; j <= loop; j++) {
            if (datamonitoring[j].buah != "") {
              var buaha = datamonitoring[j].buah;
              var buahb = select[i].buah;
              var spa = datamonitoring[j].sp;
              var spb = valuess[0]['SP'];
              datamonitoring[j].sp = '$spa & $spb';
              datamonitoring[j].buah = '$buaha & $buahb';
            } else if (datamonitoring[j].buah == "") {
              datamonitoring[j].sp = valuess[0]['SP'];
              datamonitoring[j].buah = select[i].buah;
            }
          }
        } else if (jsp > 1) {
          for (var c = 1; c <= jsp; c++) {
            if (c == 1) {
              var cek = valuess[0]['startsp2'] - 1 + int.parse(select[i].tk);
              var lastcek = cek >= loop ? loop : cek;
              for (var j = start; j <= lastcek; j++) {
                if (datamonitoring[j].buah != "") {
                  var buaha = datamonitoring[j].buah;
                  var buahb = select[i].buah;
                  var spa = datamonitoring[j].sp;
                  var spb = valuess[0]['SP'];
                  datamonitoring[j].sp = '$spa & $spb';
                  datamonitoring[j].buah = '$buaha & $buahb';
                } else if (datamonitoring[j].buah == "") {
                  datamonitoring[j].sp = valuess[0]['SP'];
                  datamonitoring[j].buah = select[i].buah;
                }
              }
            } else if (c > 1) {
              var next = c + 1;
              var cek = valuess[0]['startsp$next'] == null
                  ? loop
                  : (valuess[0]['startsp$next'] - 1) + int.parse(select[i].tk);
              var starts = (valuess[0]['startsp$c'] + int.parse(select[i].tk));
              var lastcek = cek >= loop ? loop : cek;
              if (starts <= loop) {
                for (var j = starts; j <= lastcek; j++) {
                  if (datamonitoring[j].buah != "") {
                    var buaha = datamonitoring[j].buah;
                    var buahb = select[i].buah;
                    var spa = datamonitoring[j].sp;
                    var spb = valuess[0]['sp$c'];
                    datamonitoring[j].sp = '$spa & $spb';
                    datamonitoring[j].buah = '$buaha & $buahb';
                  } else if (datamonitoring[j].buah == "") {
                    datamonitoring[j].sp = valuess[0]['sp$c'];
                    datamonitoring[j].buah = select[i].buah;
                  }
                }
              }
            }
          }
        }
      }
      //////////////////////////////////////////////////////
      //endsecondfixx//////////////////////////////////////
      ////////////////////////////////////////////////////
      ///////////////////////////////////////////////////
      //third///////////////////////////////////////////
      /////////////////////////////////////////////////
      else if (select[i].tk.contains('-') == false &&
          select[i].pb.contains('-') == false) {
        // print("ssssssss");
        var loop = int.parse(select[i].pk);
        var start = int.parse(select[i].tk);
        var valuess;
        await Firestore.instance
            .collection('tanaman')
            .where('tanggal tanam', isEqualTo: select[i].waktu)
            .getDocuments()
            .then((value) => valuess = value.documents);
        print("][][][][][][][]");
        print(valuess[0]['buah']);
        print(loop);
        print(start);
        print("////////////////");
        var jsp = valuess[0]['jsp'];
        if (jsp == 1) {
          for (var j = start; j <= loop; j++) {
            if (datamonitoring[j].buah != "") {
              var buaha = datamonitoring[j].buah;
              var buahb = select[i].buah;
              var spa = datamonitoring[j].sp;
              var spb = valuess[0]['SP'];
              datamonitoring[j].sp = '$spa & $spb';
              datamonitoring[j].buah = '$buaha & $buahb';
            } else if (datamonitoring[j].buah == "") {
              datamonitoring[j].sp = valuess[0]['SP'];
              datamonitoring[j].buah = select[i].buah;
            }
          }
        } else if (jsp > 1) {
          for (var c = 1; c <= jsp; c++) {
            if (c == 1) {
              var cek = valuess[0]['startsp2'] - 1 + int.parse(select[i].tk);
              for (var j = start; j <= cek; j++) {
                if (datamonitoring[j].buah != "") {
                  var buaha = datamonitoring[j].buah;
                  var buahb = select[i].buah;
                  var spa = datamonitoring[j].sp;
                  var spb = valuess[0]['SP'];
                  datamonitoring[j].sp = '$spa & $spb';
                  datamonitoring[j].buah = '$buaha & $buahb';
                } else if (datamonitoring[j].buah == "") {
                  datamonitoring[j].sp = valuess[0]['SP'];
                  datamonitoring[j].buah = select[i].buah;
                }
              }
            } else if (c > 1) {
              var next = c + 1;
              var cek = valuess[0]['startsp$next'] == null
                  ? loop
                  : (valuess[0]['startsp$next'] - 1) + int.parse(select[i].tk);
              var starts = (valuess[0]['startsp$c'] + int.parse(select[i].tk));
              for (var j = starts; j <= cek; j++) {
                if (datamonitoring[j].buah != "") {
                  var buaha = datamonitoring[j].buah;
                  var buahb = select[i].buah;
                  var spa = datamonitoring[j].sp;
                  var spb = valuess[0]['sp$c'];
                  datamonitoring[j].sp = '$spa & $spb';
                  datamonitoring[j].buah = '$buaha & $buahb';
                } else if (datamonitoring[j].buah == "") {
                  datamonitoring[j].sp = valuess[0]['sp$c'];
                  datamonitoring[j].buah = select[i].buah;
                }
              }
            }
          }
        }
      }
      ////////////////////////////////////////////////////
      //endthird/////////////////////////////////////////
      //////////////////////////////////////////////////
      //fourthfixx/////////////////////////////////////
      ////////////////////////////////////////////////
      else if (select[i].tk.contains('-') == true &&
          select[i].pb.contains('-') == true) {
        print(select[i].pk + ' haloo');
        var pk = int.parse(select[i].pk);
        var kurang = int.parse(select[i].pb);
        var loop = pk + kurang;
        var valuess;
        await Firestore.instance
            .collection('tanaman')
            .where('tanggal tanam', isEqualTo: select[i].waktu)
            .getDocuments()
            .then((value) => valuess = value.documents);
        print("------------------------");
        print(valuess[0]['buah']);
        print(loop);
        // print(start);
        print("////////////////");
        var jsp = valuess[0]['jsp'];
        if (jsp == 1) {
          for (var j = 0; j <= loop; j++) {
            // print('$j isi');
            if (datamonitoring[j].buah != "") {
              var buaha = datamonitoring[j].buah;
              var buahb = select[i].buah;
              var spa = datamonitoring[j].sp;
              var spb = valuess[0]['SP'];
              datamonitoring[j].sp = '$spa & $spb';
              datamonitoring[j].buah = '$buaha & $buahb';
            } else if (datamonitoring[j].buah == "") {
              datamonitoring[j].sp = valuess[0]['SP'];
              datamonitoring[j].buah = select[i].buah;
            }
          }
        } else if (jsp > 1) {
          for (var c = 1; c <= jsp; c++) {
            if (c == 1) {
              var cek = valuess[0]['startsp2'] - 1 + int.parse(select[i].tk);
              if (cek >= 0 && cek < loop) {
                for (var j = 0; j <= cek; j++) {
                  // print('$j isiw');
                  if (datamonitoring[j].buah != "") {
                    var buaha = datamonitoring[j].buah;
                    var buahb = select[i].buah;
                    var spa = datamonitoring[j].sp;
                    var spb = valuess[0]['SP'];
                    datamonitoring[j].sp = '$spa & $spb';
                    datamonitoring[j].buah = '$buaha & $buahb';
                  } else if (datamonitoring[j].buah == "") {
                    datamonitoring[j].sp = valuess[0]['SP'];
                    datamonitoring[j].buah = select[i].buah;
                  }
                }
              } else if (cek >= 0 && cek >= loop) {
                for (var j = 0; j <= loop; j++) {
                  // print('$j isiw');
                  if (datamonitoring[j].buah != "") {
                    var buaha = datamonitoring[j].buah;
                    var buahb = select[i].buah;
                    var spa = datamonitoring[j].sp;
                    var spb = valuess[0]['SP'];
                    datamonitoring[j].sp = '$spa & $spb';
                    datamonitoring[j].buah = '$buaha & $buahb';
                  } else if (datamonitoring[j].buah == "") {
                    datamonitoring[j].sp = valuess[0]['SP'];
                    datamonitoring[j].buah = select[i].buah;
                  }
                }
              }
            } else if (c > 1) {
              var next = c + 1;
              var cek = valuess[0]['startsp$next'] == null
                  ? loop
                  : (valuess[0]['startsp$next'] - 1) + int.parse(select[i].tk);
              var starts =
                  (valuess[0]['startsp$c'] + int.parse(select[i].tk)) < 0
                      ? 0
                      : (valuess[0]['startsp$c'] + int.parse(select[i].tk));
              var lastcek = cek >= loop ? loop : cek;
              if (starts <= loop && lastcek >= 0) {
                for (var j = starts; j <= lastcek; j++) {
                  // print('$j isikkk');
                  if (datamonitoring[j].buah != "") {
                    var buaha = datamonitoring[j].buah;
                    var buahb = select[i].buah;
                    var spa = datamonitoring[j].sp;
                    var spb = valuess[0]['sp$c'];
                    datamonitoring[j].sp = '$spa & $spb';
                    datamonitoring[j].buah = '$buaha & $buahb';
                  } else if (datamonitoring[j].buah == "") {
                    datamonitoring[j].sp = valuess[0]['sp$c'];
                    datamonitoring[j].buah = select[i].buah;
                  }
                }
              }
            }
          }
        }
      }
      ///////////////////////////////////////////////////////
      //endfourthfixx///////////////////////////////////////
      /////////////////////////////////////////////////////
    }
    if (buahs != '') {
      for (var i = 0; i < datamonitoring.length; i++) {
        if (datamonitoring[i].buah.contains(buahs) == true) {
          filtered.add(Filters(
              datamonitoring[i].tahun.toString(),
              datamonitoring[i].buah,
              datamonitoring[i].sp,
              datamonitoring[i].nutrisi,
              datamonitoring[i].air,
              datamonitoring[i].ph,
              datamonitoring[i].lampu,
              datamonitoring[i].catatan));
        }
      }
      excelf();
    } else if (buahs == '') {
      excel();
      // setState(() {
      //   load = 0;
      // });
    }
  }

  getsp() async {
    DateTime panenkecil = DateTime.parse(awal + ' 00:00');
    DateTime panenbesar = DateTime.parse(akhir + ' 00:00');
    var tgl = DateTime(panenkecil.year, panenkecil.month, panenkecil.day);
    var tgl2 = DateTime(panenbesar.year, panenbesar.month, panenbesar.day - 1);

    for (var k = 0; k < select.length; k++) {
      var buah;
      await Firestore.instance
          .collection("tanaman")
          .where('buah', isEqualTo: select[k].buah)
          .getDocuments()
          .then((value) => buah = value.documents);

      if (buah.length > 1) {
        for (var j = 0; j < buah.length; j++) {
          if (buah[j]['tanggal panen'] == "") {
            var waktu = Timestamp.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch);
            var date = DateTime.parse(waktu.toDate().toString());
            var datec = DateTime(date.year, date.month, date.day);
            var difference = datec.difference(tgl).inDays;
            var diff = tgl2.difference(datec).inDays;
            Timestamp times = buah[j]['tanggal tanam'];
            var dates = DateTime.parse(times.toDate().toString());
            var converts = DateTime(dates.year, dates.month, dates.day);
            var differences = converts.difference(tgl).inDays;
            if (differences.toString() == select[k].tk.toString() &&
                difference.toString() == select[k].pk.toString() &&
                diff.toString() == select[k].pb) {
              var jsp = buah[j]['jsp'];
              if (jsp == 1) {
                if (select[k].tk.contains('-') == true &&
                    select[k].pb.contains('-') == false) {
                  var loop = int.parse(select[k].pk);
                  // print('$loop loop');
                  for (var a = 0; a <= loop; a++) {
                    // print('$j isi');
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].pb.contains('-') == true &&
                    select[k].tk.contains('-') == false) {
                  var kurang = int.parse(select[k].pb);
                  // print('$kurang kurang');
                  var pk = int.parse(select[k].pk);
                  var loop = pk + kurang;
                  var start = int.parse(select[k].tk);
                  for (var a = start; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].tk.contains('-') == false &&
                    select[k].pb.contains('-') == false) {
                  // print("ssssssss");
                  var loop = int.parse(select[k].pk);
                  var start = int.parse(select[k].tk);
                  for (var a = start; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].tk.contains('-') == true &&
                    select[k].pb.contains('-') == true) {
                  var pk = int.parse(select[k].pk);
                  var kurang = int.parse(select[k].pb);
                  var loop = pk + kurang;
                  for (var a = 0; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                }
              }
            }
          } else if (buah[j]['tanggal panen'] != "") {
            Timestamp timestamps = buah[j]['tanggal panen'];
            var date2 = DateTime.parse(timestamps.toDate().toString());
            var convert = DateTime(date2.year, date2.month, date2.day);
            // print(buah[i]['buah']);
            Timestamp times = buah[j]['tanggal tanam'];
            var dates = DateTime.parse(times.toDate().toString());
            var converts = DateTime(dates.year, dates.month, dates.day);
            var differences = converts.difference(tgl).inDays;
            // var diffs = tgl2.difference(converts).inDays;

            var difference = convert.difference(tgl).inDays;
            var diff = tgl2.difference(convert).inDays;
            if (differences.toString() == select[k].tk.toString() &&
                difference.toString() == select[k].pk.toString() &&
                diff.toString() == select[k].pb) {
              var jsp = buah[j]['jsp'];
              if (jsp == 1) {
                if (select[k].tk.contains('-') == true &&
                    select[k].pb.contains('-') == false) {
                  var loop = int.parse(select[k].pk);
                  for (var a = 0; a <= loop; a++) {
                    // print('$j isi');
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].pb.contains('-') == true &&
                    select[k].tk.contains('-') == false) {
                  var kurang = int.parse(select[k].pb);
                  // print('$kurang kurang');
                  var pk = int.parse(select[k].pk);
                  var loop = pk + kurang;
                  var start = int.parse(select[k].tk);
                  for (var a = start; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].tk.contains('-') == false &&
                    select[k].pb.contains('-') == false) {
                  // print("ssssssss");
                  var loop = int.parse(select[k].pk);
                  var start = int.parse(select[k].tk);
                  for (var a = start; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                } else if (select[k].tk.contains('-') == true &&
                    select[k].pb.contains('-') == true) {
                  var pk = int.parse(select[k].pk);
                  var kurang = int.parse(select[k].pb);
                  var loop = pk + kurang;
                  for (var a = 0; a <= loop; a++) {
                    datamonitoring[a].sp = buah[j]['SP'];
                  }
                }
              } else if (jsp > 1) {
                // for(var i )
              }
            }
          }
        }
      } else if (buah.length == 1) {
        if (buah[0]['tanggal panen'] == "") {
          var waktu = Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch);
          var date = DateTime.parse(waktu.toDate().toString());
          var datec = DateTime(date.year, date.month, date.day);
          var difference = datec.difference(tgl).inDays;
          var diff = tgl2.difference(datec).inDays;
          Timestamp times = buah[0]['tanggal tanam'];
          var dates = DateTime.parse(times.toDate().toString());
          var converts = DateTime(dates.year, dates.month, dates.day);
          var differences = converts.difference(tgl).inDays;
          if (differences.toString() == select[k].tk.toString() &&
              difference.toString() == select[k].pk.toString() &&
              diff.toString() == select[k].pb) {
            var jsp = buah[0]['jsp'];
            if (jsp == 1) {
              if (select[k].tk.contains('-') == true &&
                  select[k].pb.contains('-') == false) {
                var loop = int.parse(select[k].pk);
                // print('$loop loop');
                for (var a = 0; a <= loop; a++) {
                  // print('$j isi');
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].pb.contains('-') == true &&
                  select[k].tk.contains('-') == false) {
                var kurang = int.parse(select[k].pb);
                // print('$kurang kurang');
                var pk = int.parse(select[k].pk);
                var loop = pk + kurang;
                var start = int.parse(select[k].tk);
                for (var a = start; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].tk.contains('-') == false &&
                  select[k].pb.contains('-') == false) {
                // print("ssssssss");
                var loop = int.parse(select[k].pk);
                var start = int.parse(select[k].tk);
                for (var a = start; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].tk.contains('-') == true &&
                  select[k].pb.contains('-') == true) {
                var pk = int.parse(select[k].pk);
                var kurang = int.parse(select[k].pb);
                var loop = pk + kurang;
                for (var a = 0; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              }
            }
          }
        } else if (buah[0]['tanggal panen'] != "") {
          Timestamp timestamps = buah[0]['tanggal panen'];
          var date2 = DateTime.parse(timestamps.toDate().toString());
          var convert = DateTime(date2.year, date2.month, date2.day);
          // print(buah[i]['buah']);
          Timestamp times = buah[0]['tanggal tanam'];
          var dates = DateTime.parse(times.toDate().toString());
          var converts = DateTime(dates.year, dates.month, dates.day);
          var differences = converts.difference(tgl).inDays;
          // var diffs = tgl2.difference(converts).inDays;

          var difference = convert.difference(tgl).inDays;
          var diff = tgl2.difference(convert).inDays;
          if (differences.toString() == select[k].tk.toString() &&
              difference.toString() == select[k].pk.toString() &&
              diff.toString() == select[k].pb) {
            var jsp = buah[0]['jsp'];
            if (jsp == 1) {
              if (select[k].tk.contains('-') == true &&
                  select[k].pb.contains('-') == false) {
                var loop = int.parse(select[k].pk);
                for (var a = 0; a <= loop; a++) {
                  // print('$j isi');
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].pb.contains('-') == true &&
                  select[k].tk.contains('-') == false) {
                var kurang = int.parse(select[k].pb);
                // print('$kurang kurang');
                var pk = int.parse(select[k].pk);
                var loop = pk + kurang;
                var start = int.parse(select[k].tk);
                for (var a = start; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].tk.contains('-') == false &&
                  select[k].pb.contains('-') == false) {
                // print("ssssssss");
                var loop = int.parse(select[k].pk);
                var start = int.parse(select[k].tk);
                for (var a = start; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              } else if (select[k].tk.contains('-') == true &&
                  select[k].pb.contains('-') == true) {
                var pk = int.parse(select[k].pk);
                var kurang = int.parse(select[k].pb);
                var loop = pk + kurang;
                for (var a = 0; a <= loop; a++) {
                  datamonitoring[a].sp = buah[0]['SP'];
                }
              }
            }
          }
        }
      }
    }
  }

  getallreport() async {
    load = 1;
    setState(() {});
    datamonitoring.clear();
    DateTime start = DateTime.parse(awal + ' 00:00');
    // var start = DateTime.parse(awal);
    DateTime end = DateTime.parse(akhir + ' 00:00');
    // var end = DateTime.parse(akhir);

    var tgl = DateTime(start.year, start.month, start.day);
    var tgl2 = DateTime(end.year, end.month, end.day);
    var difference = tgl2.difference(tgl).inDays;
    // print(end);
    var hasil;
    var hasil2;
    var hasil3;
    var hasil4;
    var notes;
    var notes2;
    var notes3;
    var notes4;

    //   print(end);
    var cek = difference;
    // print(cek);
    if (cek <= 0) {
      setState(() {
        load = 0;
        _showDialog("Failed", "date invalid");
      });
    }
    // print(cek);
    else if (cek != 0) {
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
        double phh = ph / hasil.length;
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
            notes.length == 0 ? "" : notes[0]['note'],
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
            double phh = ph / hasil2.length;
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
                notes2.length == 0 ? "" : notes2[0]['note'],
                "",
                ""));
          } else if (i != 0 && i != cek - 1) {
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
                notes3.length == 0 ? "" : notes3[0]['note'],
                "",
                ""));
          } else if (i == cek - 1) {
            await Firestore.instance
                .collection("Sensor")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day - 1, 0),
                    isLessThan: end)
                .getDocuments()
                .then((value) => hasil4 = value.documents);
            await Firestore.instance
                .collection("catatan")
                .where("tanggal dan waktu",
                    isGreaterThanOrEqualTo:
                        DateTime(end.year, end.month, end.day - 1, 0),
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
                notes4.length == 0 ? "" : notes4[0]['note'],
                "",
                ""));
            // print(999);
            //  print(hasil.length );
          }
        }
      }
      buah1();
      // excel();
      // print(datamonitoring[0].tanggal);
      // print(datamonitoring.length);
      // Timestamp timestamp = hasil[47]['tanggal dan waktu'];
      // var date = DateTime.parse(timestamp.toDate().toString());

    }
  }

  @override
  void initState() {
    gettime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: Column(
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
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.3),
                        child: Text(
                          "EXPORT",
                          style: TextStyle(
                              color: Color.fromRGBO(198, 198, 198, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: InkWell(
                        onTap: () {
                          buah1();
                        },
                        child: Text(
                          "Export",
                          style: TextStyle(
                              color: Color.fromRGBO(82, 82, 82, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Inter'),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: Text(
                        "What do you want to export ?",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize:
                                MediaQuery.of(context).size.width * 0.0380),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: Text(
                        "Date",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.07,
                            ),
                            child: Text(
                              "From",
                              style: TextStyle(
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.0380),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              "To",
                              style: TextStyle(
                                  color: Color.fromRGBO(183, 183, 183, 1),
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.0380),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.07,
                            ),
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2100))
                                    .then((date) {
                                  setState(() {
                                    awal =
                                        DateFormat('yyyy-MM-dd').format(date);
                                    ts = DateFormat('d LLL y').format(date);
                                  });
                                });
                              },
                              child: Text(
                                ts,
                                style: TextStyle(
                                  color: Color.fromRGBO(82, 82, 82, 1),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.08),
                            child: SvgPicture.asset(
                              "assets/Group 44.svg",
                              height: MediaQuery.of(context).size.width * 0.07,
                              width: MediaQuery.of(context).size.width * 0.07,
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.07,
                            ),
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2100))
                                    .then((date) {
                                  setState(() {
                                    var tglakhir = DateTime(
                                        date.year, date.month, date.day + 1);
                                    akhir = DateFormat('yyyy-MM-dd')
                                        .format(tglakhir);
                                    ts2 = DateFormat('d LLL y').format(date);
                                  });
                                });
                              },
                              child: Text(
                                ts2,
                                style: TextStyle(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontFamily: "Inter"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: Text(
                        "Fruits",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                    ),
                  ),
                  Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return datafilter[index].buah == 'hapus'
                              ? Padding(
                                  padding: EdgeInsets.only(top: 0),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      buahs = datafilter[index].buah;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            0.03),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
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
                                                  border: Border.all(
                                                      width: 2,
                                                      color: buahs ==
                                                              datafilter[index]
                                                                  .buah
                                                          ? Colors.green
                                                          : Colors.white),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        color: Colors.grey[300],
                                                        offset: Offset(0, 5),
                                                        spreadRadius: 3)
                                                  ]),
                                              child: SvgPicture.asset(
                                                foto[index],
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Text(
                                                datafilter[index].buah,
                                                style: TextStyle(
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w500,
                                                    color: buahs ==
                                                            datafilter[index]
                                                                .buah
                                                        ? Color.fromRGBO(
                                                            82, 82, 82, 1)
                                                        : Color.fromRGBO(
                                                            182, 182, 182, 1)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                        itemCount: datafilter.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  req();
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(151, 241, 144, 1),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey[300],
                            offset: Offset(0, 5),
                            spreadRadius: 3)
                      ]),
                  child: Center(
                      child: load == 1
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "EXPORT NOW",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w900,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06),
                            )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
