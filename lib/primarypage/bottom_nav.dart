import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydroponic/class/class.dart';
import 'package:hydroponic/list/list.dart';
import 'package:hydroponic/primarypage/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydroponic/primarypage/history.dart';
import 'package:hydroponic/primarypage/plant.dart';
import 'package:hydroponic/primarypage/profile.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  getsetpoint() async {
    strawberry.clear();
    tomato.clear();
    watermelon.clear();
    orange.clear();
    blueberry.clear();
    mango.clear();
    apple.clear();
    eggplant.clear();
    greenchili.clear();
    var datasp;
    await Firestore.instance
        .collection('setpoint-collection')
        .getDocuments()
        .then((value) => datasp = value.documents);

    for (var i = 0; i < datasp.length; i++) {
      if (datasp[i]['buah'] == "Strawberry") {
        var vals = datasp[i]['value'].split('#');
        strawberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Tomato") {
        var vals = datasp[i]['value'].split('#');
        tomato.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Orange") {
        var vals = datasp[i]['value'].split('#');
        orange.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Apple") {
        var vals = datasp[i]['value'].split('#');
        apple.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Egg Plant") {
        var vals = datasp[i]['value'].split('#');
        eggplant.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Blueberry") {
        var vals = datasp[i]['value'].split('#');
        blueberry.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Mango") {
        var vals = datasp[i]['value'].split('#');
        mango.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Watermelon") {
        var vals = datasp[i]['value'].split('#');
        watermelon.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      } else if (datasp[i]['buah'] == "Green Chili") {
        var vals = datasp[i]['value'].split('#');
        greenchili.add(Setpoint(datasp[i]['spname'], vals[1].toString(),
            vals[2].toString(), vals[3].toString()));
      }
    }
    // print("finish");
  }

  int _currentIndex = 0;
  DateTime backbuttonpressedTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    exit(0);
    return true;
  }

  List<Widget> tabs = <Widget>[Dashboard(), History(), Plant(), Profile()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // body: tabs[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/Rectangle.svg",
                ),
                activeIcon: SvgPicture.asset(
                  "assets/Group 64.svg",
                ),
                title: Text("Home"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/Vector 21.svg"),
                activeIcon: SvgPicture.asset(
                  "assets/Group 49.svg",
                ),
                title: Text("History"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/plant icon.svg"),
                activeIcon: SvgPicture.asset(
                  "assets/Group 104.svg",
                ),
                title: Text("Plant"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/user icon.svg"),
                activeIcon: SvgPicture.asset("assets/Group 105.svg",
                    color: Color.fromRGBO(111, 229, 123, 1)),
                title: Text("Profile"),
                backgroundColor: Colors.white),
          ],
          onTap: (index) async {
            if (index == 2) {
              await getsetpoint();
            }
            setState(() {
              _currentIndex = index;
              // print(index);
            });
          },
        ),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
      ),
      onWillPop: onWillPop,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [Dashboard(), History(), Plant(), Profile()].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
