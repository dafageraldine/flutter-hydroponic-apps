import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
// import 'package:hidroponik/primarypage/dashboard.dart';
import 'package:hydroponic/primarypage/login.dart';
import 'package:hydroponic/primarypage/subpage/adduser.dart';
import 'package:hydroponic/primarypage/subpage/notifications.dart';
import 'package:hydroponic/primarypage/subpage/profilesettings.dart';
import 'package:hydroponic/primarypage/subpage/recent.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;

  getlog() async {
    var val;
    await Firestore.instance
        .collection('log')
        .orderBy("tanggal", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);
    // print(val[0]['pesan']);
    log.clear();
    if (val.isNotEmpty) {
      for (var i = 0; i < val.length; i++) {
        Timestamp timestamp = val[i]['tanggal'];
        var date = DateTime.parse(timestamp.toDate().toString());
        log.add(Log(val[i]['jenis'], val[i]['pesan'], date));
      }
    }
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => Notif()));
  }

  getactivity() async {
    var val;
    // try {
    await Firestore.instance
        .collection('activity')
        // .where("by", isEqualTo: profil[0].email)
        .orderBy("tanggal", descending: true)
        .getDocuments()
        .then((value) => val = value.documents);

    aktifitas.clear();
    if (val.isNotEmpty) {
      // val.length > 1
      //     ? await Firestore.instance
      //         .collection('activity')
      //         .orderBy("tanggal", descending: true)
      //         .where("by", isEqualTo: profil[0].email,)
      //         .getDocuments()
      //         .then((value) => val = value.documents)
      //     : print("");
      for (var i = 0; i < val.length; i++) {
        if (val[i]['by'] == profil[0].email) {
          Timestamp timestamp = val[i]['tanggal'];
          var date = DateTime.parse(timestamp.toDate().toString());
          aktifitas.add(Aktifitas(val[i]['jenis'], val[i]['pesan'], date));
        }
      }
    }
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => Recent()));
    // print(aktifitas.length);
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
          ],
        );
      },
    );
  }

  void _showDialogs(judul, konten) {
    // flutter defined function
    showDialog(
      barrierDismissible: konten == 'do you want to log out ?' ? false : true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(judul),
          content: new Text(konten),
          actions: <Widget>[
            konten == 'do you want to log out ?'
                ? FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(color: Colors.green[400]),
                    ),
                    onPressed: () async {
                      await delete();
                    },
                  )
                :
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.green[400]),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "yes",
        style: TextStyle(color: Colors.green[400]),
      ),
      onPressed: () async {
        await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want to log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future getImage() async {
    print("object");
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _showDialog("Information", "Uploading please wait");
      setState(() {
        _image = image;
        print('Image Path $_image');
      });
      String foto = p.basename(_image.path);
      StorageReference firebase = FirebaseStorage.instance.ref().child(foto);
      StorageUploadTask uploadTask = firebase.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      await run(foto);
      await deleteimage();
      // print(foto);
      // Navigator.of(context).pop() = await uploadTask.onComplete;
      geturl(foto);
    }
  }

  geturl(String nama) async {
    FirebaseStorage storage =
        new FirebaseStorage(storageBucket: 'gs://autohydro-a90c1.appspot.com/');
    StorageReference imageLink = storage.ref().child(nama);
    profil[0].urlfoto = await imageLink.getDownloadURL();
    setState(() {});
    Navigator.of(context, rootNavigator: true).pop();
    // print('finish');
  }

  deleteimage() async {
    if (profil[0].urlfotoawal != "placeholder-profile-sq.jpg") {
      StorageReference storage =
          await FirebaseStorage.instance.getReferenceFromUrl(profil[0].urlfoto);
      await storage.delete();
    }
  }

  delete() async {
    var file1 = await getfile("token.txt");
    file1.delete();
    var file2 = await getfile("tokenz.txt");
    file2.delete();
    profil.clear();
    foto.clear();
    color.clear();
    tampilan.clear();
    strawberry.clear();
    tomato.clear();
    watermelon.clear();
    orange.clear();
    blueberry.clear();
    mango.clear();
    apple.clear();
    eggplant.clear();
    greenchili.clear();
    jumlahdata.clear();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  getfile(files) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$files');
    return file;
  }

  Future<String> read(files) async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$files');
      text = await file.readAsString();
    } catch (e) {
      return "no teks";
    }
    // print(text);
    return text;
  }

  run(foto) async {
    var pass = await read("tokenz.txt");
    var email = await read('token.txt');
    var id;
    id = await Firestore.instance
        .collection('akun')
        .getDocuments()
        .then((value) => id = value.documents);
    // print(id.length);
    // print(id[0]['email']);
    // var role;var uname;

    for (var i = 0; i < id.length; i++) {
      if (id[i]['email'] == email && id[i]['pass'] == pass) {
        var doc = id[i].documentID;
        await Firestore.instance
            .collection('akun')
            .document(doc)
            .updateData({'foto': foto});
        //  role = id[i]['role'];
        //  uname = id[i]['username'];
        //  await _write('$email' + ',$pass');
        //  print(token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                "assets/Rectangle 44 (1).svg",
                width: MediaQuery.of(context).size.width * 0.8,
              )),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: profil[0].urlfoto,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 10,
                                    offset: Offset(0, 8))
                              ]),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.1),
                        child: IconButton(
                            icon: Icon(Icons.camera_alt,
                                color: Color.fromRGBO(85, 85, 85, 1)),
                            onPressed: () {
                              getImage();
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    profil[0].name,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(85, 85, 85, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.02),
                //   child: Container(
                //       width: MediaQuery.of(context).size.width * 0.6,
                //       child: Text(
                //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                //         style: TextStyle(
                //             fontFamily: 'Inter normal',
                //             fontWeight: FontWeight.normal,
                //             color: Color.fromRGBO(166, 166, 166, 1),
                //             fontSize:
                //                 MediaQuery.of(context).size.width * 0.034),
                //       )),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.37),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Active",
                            style: TextStyle(
                                fontFamily: 'Inter normal',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(166, 166, 166, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034),
                          ),
                          Text(
                            jumlahuser[0].toString(),
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(77, 77, 77, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Plants",
                            style: TextStyle(
                                fontFamily: 'Inter normal',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(166, 166, 166, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034),
                          ),
                          Text(
                            datareport.length.toString(),
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(77, 77, 77, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                InkWell(
                    onTap: () async {
                      showAlertDialog(context);
                    },
                    child: Text("Log Out",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.05))),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04),
                  child: profil[0].role == "admin"
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => Adduser()));
                          },
                          child: Text("Add New User",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(85, 85, 85, 1),
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04)))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Profilesettings()));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 3.0,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: SvgPicture.asset(
                                    "assets/setting.svg",
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                getlog();
                                // Navigator.of(context, rootNavigator: true).push(
                                //     MaterialPageRoute(
                                //         builder: (context) => Notif()));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 3.0,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/notif.svg",
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                ),
                profil[0].role == 'admin'
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Profilesettings()));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 3.0,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: SvgPicture.asset(
                                    "assets/setting.svg",
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                getlog();
                                // Navigator.of(context, rootNavigator: true).push(
                                //     MaterialPageRoute(
                                //         builder: (context) => Notif()));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 3.0,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/notif.svg",
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    : Text(""),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () async {
                            // await getactivity();
                          },
                          child: Text(
                            "Recent activities",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(85, 85, 85, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "All activities that you have done will be\ndisplayed here",
                            style: TextStyle(
                                fontFamily: 'Inter normal',
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(166, 166, 166, 1),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          InkWell(
                            onTap: () async {
                              await getactivity();
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                  color: Color.fromRGBO(96, 168, 90, 1),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.034,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      aktifitas[i].jenis == "ubah"
                                          ? "assets/setting.svg"
                                          : "assets/plus.svg",
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Text(
                                      aktifitas[i].jenis == "ubah"
                                          ? "You have"
                                          : "New fruit:",
                                      style: TextStyle(
                                          fontFamily: 'Inter normal',
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromRGBO(85, 85, 85, 1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.034),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Text(
                                      aktifitas[i].jenis == "ubah"
                                          ? aktifitas[i].pesan.length > 27
                                              ? aktifitas[i]
                                                      .pesan
                                                      .substring(0, 26) +
                                                  ".."
                                              : aktifitas[i].pesan
                                          : aktifitas[i].pesan,
                                      style: TextStyle(
                                          fontFamily: 'Inter normal',
                                          fontWeight: FontWeight.w900,
                                          color:
                                              Color.fromRGBO(111, 229, 123, 1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.034),
                                    ),
                                    aktifitas[i].jenis == "tambah"
                                        ? Text(
                                            " Succesfully added",
                                            style: TextStyle(
                                                fontFamily: 'Inter normal',
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    85, 85, 85, 1),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.034),
                                          )
                                        : SizedBox(
                                            height: 0,
                                          )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.09),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateFormat('d LLL HH:mm')
                                          .format(aktifitas[i].time),
                                      style: TextStyle(
                                          fontFamily: 'Inter normal',
                                          fontWeight: FontWeight.normal,
                                          color:
                                              Color.fromRGBO(166, 166, 166, 1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: aktifitas.isEmpty
                            ? 0
                            : aktifitas.length >= 2 ? 2 : aktifitas.length,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.03),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             "assets/plus.svg",
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.07,
                      //           ),
                      //           SizedBox(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.02,
                      //           ),
                      //           Text(
                      //             "New fruit:",
                      //             style: TextStyle(
                      //                 fontFamily: 'Inter normal',
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Color.fromRGBO(85, 85, 85, 1),
                      //                 fontSize:
                      //                     MediaQuery.of(context).size.width *
                      //                         0.034),
                      //           ),
                      //           SizedBox(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.02,
                      //           ),
                      //           Text(
                      //             "Apple",
                      //             style: TextStyle(
                      //                 fontFamily: 'Inter normal',
                      //                 fontWeight: FontWeight.w900,
                      //                 color: Color.fromRGBO(111, 229, 123, 1),
                      //                 fontSize:
                      //                     MediaQuery.of(context).size.width *
                      //                         0.034),
                      //           ),
                      //           SizedBox(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.02,
                      //           ),
                      //           Text(
                      //             "Succesfully added",
                      //             style: TextStyle(
                      //                 fontFamily: 'Inter normal',
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Color.fromRGBO(85, 85, 85, 1),
                      //                 fontSize:
                      //                     MediaQuery.of(context).size.width *
                      //                         0.034),
                      //           ),
                      //         ],
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             left:
                      //                 MediaQuery.of(context).size.width * 0.09),
                      //         child: Align(
                      //           alignment: Alignment.centerLeft,
                      //           child: Text(
                      //             "13 Nov",
                      //             style: TextStyle(
                      //                 fontFamily: 'Inter normal',
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Color.fromRGBO(166, 166, 166, 1),
                      //                 fontSize:
                      //                     MediaQuery.of(context).size.width *
                      //                         0.03),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
