import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:http/http.dart' as http;

class Addmoreplant extends StatefulWidget {
  @override
  _AddmoreplantState createState() => _AddmoreplantState();
}

class _AddmoreplantState extends State<Addmoreplant> {
  TextEditingController nama = new TextEditingController();
  TextEditingController latin = new TextEditingController();
  TextEditingController deskripsi = new TextEditingController();
  TextEditingController sp = new TextEditingController();
  TextEditingController lampu = new TextEditingController();
  TextEditingController nutrisi = new TextEditingController();
  TextEditingController ph = new TextEditingController();
  var isLoading = 0;

  Future getnotif() async {
    // var buah = nama.text;
    http.Response cek = await http
        .get(linkApi + "send_notifications_tambahtanaman/" + nama.text);
    // print(linkApi + "send_notifications_tambahtanaman/" + "$buah");
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
    }
  }

  tambahbuah() async {
    setState(() {
      isLoading = 1;
    });
    // var time = DateTime.now().millisecondsSinceEpoch.toString();
    if (nama.text.isNotEmpty &&
        latin.text.isNotEmpty &&
        deskripsi.text.isNotEmpty &&
        sp.text.isNotEmpty &&
        ph.text.isNotEmpty &&
        lampu.text.isNotEmpty &&
        nutrisi.text.isNotEmpty) {
      await Firestore.instance.collection('customplant').document().setData({
        "tanaman": nama.text,
        "latin": latin.text,
        "deskripsi": deskripsi.text,
        "status": "aktif"
      });

      await Firestore.instance
          .collection('setpoint-collection')
          .document()
          .setData({
        'buah': nama.text,
        'spname': sp.text,
        'value': '#' + ph.text + '#' + lampu.text + '#' + nutrisi.text,
      });

      await Firestore.instance.collection('activity').document().setData({
        "by": profil[0].email,
        "jenis": "tambah",
        "pesan": nama.text,
        "tanggal": Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
      });
      await getcustomplant();
      getnotif();
      setState(() {
        isLoading = 0;
        nama.clear();
        latin.clear();
        deskripsi.clear();
        sp.clear();
        ph.clear();
        lampu.clear();
        nutrisi.clear();
      });
      _showDialog("Success", "berhasil menyimpan data" + nama.text);
    } else {
      setState(() {
        isLoading = 0;
      });
      _showDialog("Warning", "Tidak boleh ada kolom yang kosong");
    }
    // await Firestore.instance.collection('tanaman').where('buah',isEqualTo: tampilan[0].buah).
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  "assets/Rectangle 46.svg",
                  width: MediaQuery.of(context).size.width * 0.8,
                )),
            Column(
              children: [
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
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.27,
                          top: MediaQuery.of(context).size.width * 0.052),
                      child: Text(
                        "Add Plant",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama Tanaman",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
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
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.white,
                      child: TextFormField(
                          controller: nama,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ex : bayam")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama Latin Tanaman",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white,
                      child: TextFormField(
                          controller: latin,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ex: amaranthus")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deskripsi Tanaman",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white,
                      child: TextFormField(
                          controller: deskripsi,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  "ex: bayam adalah sejenis sayuran hijau yang menyehatkan")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama Setpoint",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.white,
                      child: TextFormField(
                          controller: sp,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ex: sp bayam 1")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.075),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Masukkan Setpoint",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.10),
                  child: Column(
                    children: [
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
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  keyboardType: TextInputType.number,
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
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  keyboardType: TextInputType.number,
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
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05),
                    child: isLoading == 1
                        ? InkWell(
                            onTap: () {
                              // tambahbuah();
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
                                        child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ))),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              tambahbuah();
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
                                        child: Text(
                                      "CREATE NOW",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w900,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                    ))),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
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
