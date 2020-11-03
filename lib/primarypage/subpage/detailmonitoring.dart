import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/list/list.dart';

class Detailmonitoring extends StatefulWidget {
  @override
  _DetailmonitoringState createState() => _DetailmonitoringState();
}

class _DetailmonitoringState extends State<Detailmonitoring> {
  void _showDialog(iter) {
    // print("start");
    // print(datamonitoring[0].tahun);
    // print(datamonitoring[0].tanggal);
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06,
                              top: MediaQuery.of(context).size.height * 0.02),
                          child: Text(
                            datamonitoring[iter].sp,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: "Inter",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              color: Colors.black,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.06),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            datamonitoring[iter].tahun,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.038,
                                color: Color.fromRGBO(186, 186, 186, 1)),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.1),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                datamonitoring[iter].nutrisi,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Inter",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Color.fromRGBO(106, 106, 106, 1),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              SvgPicture.asset(
                                "assets/vitamins.svg",
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              Text(
                                "Nutrisi",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(186, 186, 186, 1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                datamonitoring[iter].air,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Inter",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Color.fromRGBO(106, 106, 106, 1),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              SvgPicture.asset(
                                "assets/flood.svg",
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              Text(
                                "Air",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(186, 186, 186, 1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                datamonitoring[iter].ph,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Inter",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Color.fromRGBO(106, 106, 106, 1),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              SvgPicture.asset(
                                "assets/ph (1).svg",
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              Text(
                                "PH",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(186, 186, 186, 1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                datamonitoring[iter].lampu,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Inter",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Color.fromRGBO(106, 106, 106, 1),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              SvgPicture.asset(
                                "assets/idea.svg",
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              Text(
                                "Lampu",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(186, 186, 186, 1)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.06,
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text(
                                datamonitoring[iter].catatan,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    color: Color.fromRGBO(92, 92, 92, 1)),
                              ))),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        "assets/Rectangle 35.svg",
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 0.9,
                        color: color[ke],
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1,
                        left: MediaQuery.of(context).size.width * 0.14),
                    child: SvgPicture.asset(foto[ke],
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: MediaQuery.of(context).size.width * 0.05,
                          color: Color.fromRGBO(0, 0, 0, 0.54),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   r= "";
                          // });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          datareport[ke].buah,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: "Inter",
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            color: color[ke],
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Daily report",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038,
                              color: Color.fromRGBO(186, 186, 186, 1)),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.13,

                        // color: Colors.white,
                        child: Row(
                          // textDirection: ,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Text(
                                datamonitoring[index].tanggal,
                                style: TextStyle(
                                    color: Color.fromRGBO(96, 168, 90, 1),
                                    fontFamily: "Inter-normal",
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.03,
                                  left: MediaQuery.of(context).size.width *
                                      0.034),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    // overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            datamonitoring[index].sp,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Inter",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.042,
                                              color: Colors.black,
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              datamonitoring[index].catatan,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.034,
                                                  fontFamily: "Inter normal",
                                                  color: Color.fromRGBO(
                                                      186, 186, 186, 1)),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.navigate_next,
                                  size:
                                      MediaQuery.of(context).size.width * 0.07,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _showDialog(index);
                                })
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: datamonitoring.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
              )
            ],
          ),
        ));
  }
}
// Stack(
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.topRight,
//                 child: SvgPicture.asset("assets/Rectangle 35.svg",width: MediaQuery.of(context).size.width * 0.9,height: MediaQuery.of(context).size.width * 0.9)),
//                 Padding(
//                   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1,left: MediaQuery.of(context).size.width * 0.1),
//                   child: SvgPicture.asset("assets/tomato.svg",width: MediaQuery.of(context).size.width * 0.8,height: MediaQuery.of(context).size.width * 0.8),
//                 ),
//               Padding(
//                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05),
//                 child: Container(
//         child: IconButton(icon: Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.width *0.05,color:  Color.fromRGBO(0, 0, 0, 0.54),), onPressed: () { Navigator.pop(context); },),
//       ),
//               ),
//             ],
//           ),

// child: Stack(
//               children: <Widget>[
//                  Align(
//                           alignment: Alignment.topRight,
//                           child: SvgPicture.asset("assets/Rectangle 35.svg",width: MediaQuery.of(context).size.width * 0.9,height: MediaQuery.of(context).size.width * 0.9)),
//                           Padding(
//                             padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1,left: MediaQuery.of(context).size.width * 0.1),
//                             child: SvgPicture.asset("assets/tomato.svg",width: MediaQuery.of(context).size.width * 0.8,height: MediaQuery.of(context).size.width * 0.8),
//                           ),
//                           Padding(
//                           padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05),
//                           child: Container(
//                   child: IconButton(icon: Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.width *0.05,color:  Color.fromRGBO(0, 0, 0, 0.54),), onPressed: () { Navigator.pop(context); },),
//                 ),
//                         ),
//               ],
//             ),
