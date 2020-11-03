import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Addnotes extends StatefulWidget {
  @override
  _AddnotesState createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
    var lx;
  
  TextEditingController catatan = new TextEditingController();

  void _showDialog(judul,konten) {
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

tambahcatatan() async {
if(catatan.text == ""){
  setState(() {
  lx =0;
    
  });
  _showDialog("Warning", "notes can't be empty");
}
  
  else if (catatan.text != "" ){
    var hari = DateTime.now();
    var haric = DateFormat('yyyy-MM-dd').format(hari);
    DateTime start =  DateTime.parse(haric + ' 00:00');
    DateTime end = DateTime.parse(haric + ' 23:59');
    var notes;

     await Firestore.instance
        .collection("catatan")
        .where("tanggal dan waktu",
            isGreaterThanOrEqualTo: start, isLessThan: end)
        .getDocuments()
        .then((value) => notes = value.documents);
        if (notes.length == 0){
          var waktu = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    await Firestore.instance.collection('catatan').document().setData({
      "note" : catatan.text,
      "tanggal dan waktu" : waktu,
      }
    );
    _showDialog("Success", "Notes added");
    setState(() {
  lx =0;
    catatan.clear();
  });
        }

        else if (notes.length !=0){
var waktu = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    await Firestore.instance.collection('catatan').document(notes[0].documentID).updateData({
      "note" : catatan.text,
      "tanggal dan waktu" : waktu,
      }
    );

          _showDialog("Success", "Notes added");
    setState(() {
  lx =0;
    catatan.clear();
  });
        }
    // var time = DateTime.now().millisecondsSinceEpoch.toString();
    
    
    }
    
  
    // update();
    // await Firestore.instance.collection('tanaman').where('buah',isEqualTo: tampilan[0].buah).
    
  }

  @override
  Widget build(BuildContext context) {
    
     SystemChrome.setEnabledSystemUIOverlays([]);
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Container(
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width *0.05,top: MediaQuery.of(context).size.width *0.05),
                    child: IconButton(icon: Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.width *0.05,color:  Color.fromRGBO(0, 0, 0, 0.54),), onPressed: () { Navigator.pop(context); },),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.22,top: MediaQuery.of(context).size.width *0.052),
                    child: Text("ADD NOTES",
                                          style: TextStyle(
                          color: Color.fromRGBO(198, 198, 198, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.034,
                          fontWeight: FontWeight.w700),),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075, top: MediaQuery.of(context).size.width * 0.4),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Notes",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.045,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                )),
                          ),
                           Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075, top: MediaQuery.of(context).size.height * 0.02),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextFormField(
                              controller: catatan,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "add your notes here")),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              lx = 1;
                            });
                            tambahcatatan();
                            // cek();
                            // cekakun();
                            // getData();
                            },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(125, 209, 151, 1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                                child: lx == 1 ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(57, 96, 69, 1)),): Text(
                          "Add Notes",
                          style: TextStyle(
                              color: Color.fromRGBO(57, 96, 69, 1),
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w700),
                        )),
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