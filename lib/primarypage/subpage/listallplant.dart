import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/subpage/detailcustomplant.dart';

import 'detailplant.dart';

class Listallplant extends StatefulWidget {
  @override
  _ListallplantState createState() => _ListallplantState();
}

class _ListallplantState extends State<Listallplant> {
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
                        "List of plants",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/green-chili-pepper.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Greenchili",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/eggplant.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Egg plant",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/apple.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Apple",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/orange.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Orange",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/blueberry.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Blueberry",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/mango.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Mango",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/watermelon.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Watermelon",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/strawberry.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Strawberry",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        SvgPicture.asset(
                          "assets/tomato.svg",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Tomato",
                          style: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.navigate_next),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            customdetail.clear();
                            customdetail.add(Customplant(custom[index].nama,
                                custom[index].latin, custom[index].deskripsi));
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => Detailcustomplant()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0,
                                      color: Colors.black12,
                                      spreadRadius: 5.0,
                                      offset: Offset(0, 8))
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                SvgPicture.asset(
                                  "assets/customplant.svg",
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(
                                  custom[index].nama,
                                  style: TextStyle(
                                      color: Color.fromRGBO(85, 85, 85, 1),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.034,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Icon(Icons.navigate_next),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: custom.length,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
