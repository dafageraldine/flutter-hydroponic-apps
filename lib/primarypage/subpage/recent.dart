import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydroponic/list/list.dart';
import 'package:intl/intl.dart';

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  "assets/Rectangle 44 (1).svg",
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
                        "Recent Activities",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                aktifitas.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.35),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          color: Colors.black12,
                                          spreadRadius: 5.0,
                                          offset: Offset(0, 8))
                                    ],
                                    color: Colors.white),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SvgPicture.asset(
                                        "assets/box.svg",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "There is no data",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromRGBO(85, 85, 85, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 5.0,
                                            offset: Offset(0, 8))
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset(
                                          aktifitas[i].jenis == "ubah"
                                              ? "assets/setting.svg"
                                              : "assets/plus.svg",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                // SvgPicture.asset(
                                                //   aktifitas[i].jenis == "ubah"
                                                //       ? "assets/setting.svg"
                                                //       : "assets/plus.svg",
                                                //   width:
                                                //       MediaQuery.of(context).size.width *
                                                //           0.07,
                                                // ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09,
                                                ),
                                                Text(
                                                  aktifitas[i].jenis == "ubah"
                                                      ? "You have"
                                                      : "New fruit:",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Inter normal',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color.fromRGBO(
                                                          85, 85, 85, 1),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.034),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                Text(
                                                  aktifitas[i].jenis == "ubah"
                                                      ? aktifitas[i]
                                                                  .pesan
                                                                  .length >
                                                              27
                                                          ? aktifitas[i]
                                                                  .pesan
                                                                  .substring(
                                                                      0, 24) +
                                                              ".."
                                                          : aktifitas[i].pesan
                                                      : aktifitas[i].pesan,
                                                  // aktifitas[i].pesan,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Inter normal',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Color.fromRGBO(
                                                          111, 229, 123, 1),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.034),
                                                ),
                                                aktifitas[i].jenis == "tambah"
                                                    ? Text(
                                                        " Succesfully added",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Inter normal',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Color.fromRGBO(
                                                                    85,
                                                                    85,
                                                                    85,
                                                                    1),
                                                            fontSize: MediaQuery.of(
                                                                        context)
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
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  DateFormat('d LLL HH:mm')
                                                      .format(
                                                          aktifitas[i].time),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Inter normal',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color.fromRGBO(
                                                          166, 166, 166, 1),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                )
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: aktifitas.isNotEmpty ? aktifitas.length : 0,
                      ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.02),
                //   child: Column(
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width * 0.83,
                //         height: MediaQuery.of(context).size.width * 0.23,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8.0),
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                   blurRadius: 5.0,
                //                   color: Colors.black12,
                //                   spreadRadius: 5.0,
                //                   offset: Offset(0, 8))
                //             ]),
                //         child: Padding(
                //           padding: EdgeInsets.only(
                //               left: MediaQuery.of(context).size.width * 0.04,
                //               top: MediaQuery.of(context).size.height * 0.02),
                //           child: Column(
                //             children: [
                //               Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     "Information",
                //                     style: TextStyle(
                //                         fontFamily: 'Inter',
                //                         fontWeight: FontWeight.w900,
                //                         color: Color.fromRGBO(85, 85, 85, 1),
                //                         fontSize:
                //                             MediaQuery.of(context).size.width *
                //                                 0.04),
                //                   )),
                //               Row(
                //                 children: [
                //                   Text(
                //                     "New fruit:",
                //                     style: TextStyle(
                //                         fontFamily: 'Inter normal',
                //                         fontWeight: FontWeight.normal,
                //                         color: Color.fromRGBO(85, 85, 85, 1),
                //                         fontSize:
                //                             MediaQuery.of(context).size.width *
                //                                 0.034),
                //                   ),
                //                   SizedBox(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.02,
                //                   ),
                //                   Text(
                //                     "Apple",
                //                     style: TextStyle(
                //                         fontFamily: 'Inter normal',
                //                         fontWeight: FontWeight.w900,
                //                         color: Color.fromRGBO(111, 229, 123, 1),
                //                         fontSize:
                //                             MediaQuery.of(context).size.width *
                //                                 0.034),
                //                   ),
                //                   SizedBox(
                //                     width: MediaQuery.of(context).size.width *
                //                         0.02,
                //                   ),
                //                   Text(
                //                     "Succesfully added",
                //                     style: TextStyle(
                //                         fontFamily: 'Inter normal',
                //                         fontWeight: FontWeight.normal,
                //                         color: Color.fromRGBO(85, 85, 85, 1),
                //                         fontSize:
                //                             MediaQuery.of(context).size.width *
                //                                 0.034),
                //                   ),
                //                 ],
                //               ),
                //               Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     "14 Nov 2020 13:25",
                //                     style: TextStyle(
                //                         fontFamily: 'Inter normal',
                //                         fontWeight: FontWeight.normal,
                //                         color: Color.fromRGBO(166, 166, 166, 1),
                //                         fontSize:
                //                             MediaQuery.of(context).size.width *
                //                                 0.03),
                //                   )),
                //             ],
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: MediaQuery.of(context).size.width * 0.02,
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
