// List data;
import 'package:flutter/cupertino.dart';
import 'package:hydroponic/class/class.dart';

List<Setp> data = <Setp>[];
List<Stacked> databar1 =
    <Stacked>[]; // Stacked("00:00", 20.0, Color.fromRGBO(96, 168, 90,1)),lampu
List<Stacked> databar2 =
    <Stacked>[]; //Color.fromRGBO(130, 255, 119,1)tinggi air
List<Stacked> databar3 = <Stacked>[]; //Color.fromRGBO(52, 104, 67 ,1)nutrisi
List<Stacked> databar4 = <Stacked>[]; //Color.fromRGBO(135, 173, 70, 0.62)PH
List<Buah> sp = <Buah>[];
List<Buah1> tampilan = <Buah1>[];
List<Report> datareport = <Report>[];
List<Monitor> datamonitoring = <Monitor>[];
List<Filters> filtered = <Filters>[];
List dummy;
List<Excelbuah> excelbuah = <Excelbuah>[];
List<Selected> select = <Selected>[];
List<Profiledata> profil = <Profiledata>[];
List<Setpoint> mango = <Setpoint>[];
List<Setpoint> tomato = <Setpoint>[];
List<Setpoint> watermelon = <Setpoint>[];
List<Setpoint> blueberry = <Setpoint>[];
List<Setpoint> orange = <Setpoint>[];
List<Setpoint> apple = <Setpoint>[];
List<Setpoint> eggplant = <Setpoint>[];
List<Setpoint> strawberry = <Setpoint>[];
List<Setpoint> greenchili = <Setpoint>[];
List<Report> datafilter = <Report>[];
List<Setpoint> tampilsp = <Setpoint>[];
var jumlahuser = [];

var fake = ["tomato", "assets/tomato.svg", "Solanum lycopersicum"];

var datab = [
  Databuah("Tomato", "Solanum lycopersicum", "assets/tomato.svg",
      Color.fromRGBO(252, 50, 75, 0.62)),
  Databuah("Mango", "Mangifera indica", "assets/mango.svg",
      Color.fromRGBO(250, 212, 76, 0.62)),
  Databuah("Watermelon", "Citrullus lanatus", "assets/watermelon.svg",
      Color.fromRGBO(135, 173, 70, 0.62)),
  Databuah("Blueberry", "Cyanococcus", "assets/blueberry.svg",
      Color.fromRGBO(108, 99, 181, 0.62)),
  Databuah("Orange", "Citrus X sinensis", "assets/orange.svg",
      Color.fromRGBO(242, 151, 55, 0.62)),
  Databuah("Apple", "Malus domestica", "assets/apple.svg",
      Color.fromRGBO(252, 50, 75, 0.62)),
  Databuah("Egg Plant", "Solanum melongena", "assets/eggplant.svg",
      Color.fromRGBO(96, 55, 155, 0.62)),
  Databuah("Strawberry", "Fragaria × ananassa", "assets/strawberry.svg",
      Color.fromRGBO(202, 48, 30, 0.62)),
  Databuah("Green Chili", "Capsicum annuum", "assets/green-chili-pepper.svg",
      Color.fromRGBO(137, 193, 64, 0.62)),
];

var foto = [];
var color = [];
var ke;
var jumlahdata = [];
List<Setp> setp = <Setp>[];
