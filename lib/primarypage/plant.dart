import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/addmoreplant.dart';
import 'package:hydroponic/primarypage/subpage/customsp.dart';
import 'package:hydroponic/primarypage/subpage/detailplant.dart';
import 'package:hydroponic/primarypage/subpage/listallplant.dart';

class Plant extends StatefulWidget {
  @override
  _PlantState createState() => _PlantState();
}

class _PlantState extends State<Plant> {
  getcustomplant() async {
    var val;
    await Firestore.instance
        .collection('customplant')
        .getDocuments()
        .then((value) => val = value.documents);
    custom.clear();
    customlog.clear();
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
      getspcustomplant();
    } else {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Listallplant()));
    }
  }

  getspcustomplant() async {
    var datasp;
    await Firestore.instance
        .collection('setpoint-collection')
        .getDocuments()
        .then((value) => datasp = value.documents);
    customplant.clear();
    if (datasp.isNotEmpty && custom.isNotEmpty) {
      for (var y = 0; y < custom.length; y++) {
        for (var i = 0; i < datasp.length; i++) {
          if (custom[y].nama == datasp[i]['buah']) {
            var vals = datasp[i]['value'].split('#');
            customplant.add(Setpointcustom(
                datasp[i]['buah'],
                datasp[i]['spname'],
                vals[1].toString(),
                vals[2].toString(),
                vals[3].toString()));
          }
        }
      }

      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Listallplant()));
    } else {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => Listallplant()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.1,
          color: Colors.white,
        ),
        Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/Rectangle 46.svg",
              width: MediaQuery.of(context).size.width * 0.8,
            )),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset(
                "assets/Rectangle 45.svg",
                width: MediaQuery.of(context).size.width * 0.6,
              )),
        ),
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  "Discover",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width * 0.1),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "hydroponic",
                        style: TextStyle(
                            color: Color.fromRGBO(209, 200, 119, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800,
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Color.fromRGBO(161, 161, 161, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800,
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                      Text(
                        "plants",
                        style: TextStyle(
                            color: Color.fromRGBO(119, 200, 122, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w800,
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  tampilsp.clear();
                  tampilsp.addAll(blueberry);
                  sp.clear();
                  sp.add(Buah(
                      "Blueberry",
                      "assets/blueberry.svg",
                      "Cyanococcus",
                      Color.fromRGBO(108, 99, 181, 0.62),
                      "blueberry merupakan tanaman buah yang berasal dari Amerika Utara yang kaya akan vitamin, termasuk vitamin C dan vitamin K."));
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => Detailplant()));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(108, 99, 181, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 13.png"),
                      ),
                      Text("Blueberry",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(tomato);
                    sp.clear();
                    sp.add(Buah(
                        "Tomato",
                        "assets/tomato.svg",
                        "Solanum lycopersicum",
                        Color.fromRGBO(252, 50, 75, 0.62),
                        "Tomat merupakan tumbuhan siklus hidup singkat, dapat tumbuh setinggi 1 sampai 3 meter."));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(252, 50, 75, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 15.png"),
                      ),
                      Text("Tomato", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(mango);
                    sp.clear();
                    sp.add(Buah(
                        "Mango",
                        "assets/mango.svg",
                        "Mangifera indica",
                        Color.fromRGBO(250, 212, 76, 0.62),
                        "Mangga adalah buah yang termasuk ke dalam marga Mangifera dan suku Anacardiaceae yang memiliki sekitar 35–40 anggota."));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 212, 76, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 17.png"),
                      ),
                      Text("Mango", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.48),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(orange);
                    sp.clear();
                    sp.add(Buah(
                        "Orange",
                        "assets/orange.svg",
                        "Citrus X sinensis",
                        Color.fromRGBO(242, 151, 55, 0.62),
                        "jeruk adalah buah yang sangat kaya akan serat, vitamin C hingga antioksidan tinggi yang ampuh mendukung kesehatan dan kebugaran tubuh."));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 151, 55, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 16.png"),
                      ),
                      Text("Orange", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(apple);
                    sp.clear();
                    sp.add(Buah(
                        "Apple",
                        "assets/apple.svg",
                        "Malus domestica",
                        Color.fromRGBO(252, 50, 75, 0.62),
                        "Apel kaya akan kandungan antioksidan, flavonoid, dan serat makanan. Kandungan tersebut membantu untuk mengurangi risiko kanker, diabetes, hingga jantung."));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(252, 50, 75, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 14.png"),
                      ),
                      Text("Apple", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(eggplant);
                    sp.clear();
                    sp.add(Buah(
                        "Egg Plant",
                        "assets/eggplant.svg",
                        "Solanum melongena",
                        Color.fromRGBO(96, 55, 155, 0.62),
                        "Terong adalah tumbuhan yang berasal dari India dan Sri Lanka.Terong dapat Membantu mengatasi asam lambung"));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(96, 55, 155, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 18.png"),
                      ),
                      Text(
                        "Egg Plant",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.68),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(watermelon);
                    sp.clear();
                    sp.add(Buah(
                        "Watermelon",
                        "assets/watermelon.svg",
                        "Citrullus lanatus",
                        Color.fromRGBO(135, 173, 70, 0.62),
                        "Semangka adalah tanaman merambat yang berasal dari daerah setengah gurun di Afrika bagian selatan.biasanya dipanen buahnya untuk dimakan segar atau dibuat jus"));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(135, 173, 70, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 19.png"),
                      ),
                      Text("Watermelon",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(greenchili);
                    sp.clear();
                    sp.add(Buah(
                        "Green Chili",
                        "assets/green-chili-pepper.svg",
                        "Capsicum annuum",
                        Color.fromRGBO(137, 193, 64, 0.62),
                        "cabe hijau adalah salah satu jenis makanan yang memiliki kandungan antioksidan yang tinggi. "));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(137, 193, 64, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 20.png"),
                      ),
                      Text("Green chili",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    tampilsp.clear();
                    tampilsp.addAll(strawberry);
                    sp.clear();
                    sp.add(Buah(
                        "Strawberry",
                        "assets/strawberry.svg",
                        "Fragaria × ananassa",
                        Color.fromRGBO(202, 48, 30, 0.62),
                        "buah strawberry adalah buah yang Cocok untuk Penderita Diabetes Tipe-2 dan Bisa Meningkatkan Kekebalan Tubuh"));
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => Detailplant()));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        //  color: Colors.black,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(202, 48, 30, 0.62),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Image.asset("assets/image 21.png"),
                      ),
                      Text(
                        "Strawberry",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.85,
              left: MediaQuery.of(context).size.width * 0.08),
          child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => Addmoreplant()));
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  //  color: Colors.black,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      )),
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/plus.svg",
                          color: Colors.grey,
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Add More Plant",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 1, bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Plant List",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.0,
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: Text(
                        "You can see list all of plants here",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await getcustomplant();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.13),
                      child: Text(
                        "See all",
                        style: TextStyle(
                            color: Color.fromRGBO(96, 168, 90, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
