import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/detailplant.dart';

class Plant extends StatefulWidget {
  @override
  _PlantState createState() => _PlantState();
}

class _PlantState extends State<Plant> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                ))
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
                  sp.add(Buah("Blueberry", "assets/blueberry.svg",
                      "Cyanococcus", Color.fromRGBO(108, 99, 181, 0.62)));
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
                    ));
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
                    ));
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
                    ));
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
                    ));
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
                    ));
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
                    ));
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
                    ));
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
                    ));
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
      ]),
    );
  }
}
