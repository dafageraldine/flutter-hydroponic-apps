import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/list/list.dart';
import 'package:intl/intl.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        "Notifications",
                        style: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.83,
                            height: MediaQuery.of(context).size.width * 0.23,
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
                                      MediaQuery.of(context).size.width * 0.04,
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        log[i].jenis,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                            color: log[i].jenis == "Information"
                                                ? Colors.green[400]
                                                : Colors.red[300],
                                            // Color.fromRGBO(85, 85, 85, 1)
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        log[i].pesan,
                                        style: TextStyle(
                                            fontFamily: 'Inter normal',
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DateFormat('d LLL y HH:mm')
                                            .format(log[i].time),
                                        style: TextStyle(
                                            fontFamily: 'Inter normal',
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromRGBO(
                                                166, 166, 166, 1),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02,
                          )
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: log.length,
                  physics: ClampingScrollPhysics(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
