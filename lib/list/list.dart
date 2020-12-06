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
List<Setpointcustom> customplant = <Setpointcustom>[];
List<Report> datafilter = <Report>[];
List<Setpoint> tampilsp = <Setpoint>[];
List<Customplant> custom = <Customplant>[];
List<Customplant> customdetail = <Customplant>[];
List<Customplant> customlog = <Customplant>[];
List<Log> log = <Log>[];
List<Aktifitas> aktifitas = <Aktifitas>[];
var jumlahuser = [];
var linkApi = "https://server-autohydro.herokuapp.com/";
var lampug;
var phg;
var nutrisig;

var fake = ["tomato", "assets/tomato.svg", "Solanum lycopersicum"];

var datab = [
  Databuah(
      "Tomato",
      "Solanum lycopersicum",
      "assets/tomato.svg",
      Color.fromRGBO(252, 50, 75, 0.62),
      "Tomat merupakan tumbuhan siklus hidup singkat, dapat tumbuh setinggi 1 sampai 3 meter."),
  Databuah(
      "Mango",
      "Mangifera indica",
      "assets/mango.svg",
      Color.fromRGBO(250, 212, 76, 0.62),
      "Mangga adalah buah yang termasuk ke dalam marga Mangifera dan suku Anacardiaceae yang memiliki sekitar 35–40 anggota."),
  Databuah(
      "Watermelon",
      "Citrullus lanatus",
      "assets/watermelon.svg",
      Color.fromRGBO(135, 173, 70, 0.62),
      "Semangka adalah tanaman merambat yang berasal dari daerah setengah gurun di Afrika bagian selatan.biasanya dipanen buahnya untuk dimakan segar atau dibuat jus"),
  Databuah(
      "Blueberry",
      "Cyanococcus",
      "assets/blueberry.svg",
      Color.fromRGBO(108, 99, 181, 0.62),
      "blueberry merupakan tanaman buah yang berasal dari Amerika Utara yang kaya akan vitamin, termasuk vitamin C dan vitamin K."),
  Databuah(
      "Orange",
      "Citrus X sinensis",
      "assets/orange.svg",
      Color.fromRGBO(242, 151, 55, 0.62),
      "jeruk adalah buah yang sangat kaya akan serat, vitamin C hingga antioksidan tinggi yang ampuh mendukung kesehatan dan kebugaran tubuh."),
  Databuah(
      "Apple",
      "Malus domestica",
      "assets/apple.svg",
      Color.fromRGBO(252, 50, 75, 0.62),
      "Apel kaya akan kandungan antioksidan, flavonoid, dan serat makanan. Kandungan tersebut membantu untuk mengurangi risiko kanker, diabetes, hingga jantung."),
  Databuah(
      "Egg Plant",
      "Solanum melongena",
      "assets/eggplant.svg",
      Color.fromRGBO(96, 55, 155, 0.62),
      "Terong adalah tumbuhan yang berasal dari India dan Sri Lanka.Terong dapat Membantu mengatasi asam lambung"),
  Databuah(
      "Strawberry",
      "Fragaria × ananassa",
      "assets/strawberry.svg",
      Color.fromRGBO(202, 48, 30, 0.62),
      "buah strawberry adalah buah yang Cocok untuk Penderita Diabetes Tipe-2 dan Bisa Meningkatkan Kekebalan Tubuh"),
  Databuah(
      "Green Chili",
      "Capsicum annuum",
      "assets/green-chili-pepper.svg",
      Color.fromRGBO(137, 193, 64, 0.62),
      "cabe hijau adalah salah satu jenis makanan yang memiliki kandungan antioksidan yang tinggi. "),
];

var foto = [];
var color = [];
var titles;
var buahedit;
var ke;
var jumlahdata = [];
var vgtanaman;
var currindex = 0;
List<Setp> setp = <Setp>[];
