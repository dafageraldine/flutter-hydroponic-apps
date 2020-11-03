import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Stacked {
  String waktu;
  var value;
  Color colorval;

  Stacked(this.waktu, this.value, this.colorval);
}

class Setp {
  String value;
  Setp(this.value);
}

class Buah {
  String buah;
  String image;
  // String ph;
  // String nutrisi;
  // String lampu;
  String latin;
  Color colorval;

  Buah(
    this.buah,
    this.image,
    this.latin,
    this.colorval,
  );
}

class Buah1 {
  String buah;
  String image;
  String latin;
  Color colorval;

  Buah1(this.buah, this.image, this.latin, this.colorval);
}

class Report {
  String buah;
  String tanggaltanam;
  String tanggalpanen;

  Report(this.buah, this.tanggaltanam, this.tanggalpanen);
}

class Reporting {
  String buah;
  String tanggaltanam;
  String tanggalpanen;

  Reporting(this.buah, this.tanggaltanam, this.tanggalpanen);
}

class Databuah {
  String buah;
  String latin;
  String image;
  Color colorval;

  Databuah(this.buah, this.latin, this.image, this.colorval);
}

class Monitor {
  String tanggal;
  String ph;
  String lampu;
  String nutrisi;
  String tahun;
  String air;
  String catatan;
  String buah;
  String sp;
  Monitor(this.tanggal, this.ph, this.lampu, this.nutrisi, this.tahun, this.air,
      this.catatan, this.buah, this.sp);
}

class Filters {
  String tahun;
  String buah;
  String sp;
  String nutrisi;
  String air;
  String ph;
  String lampu;
  String catatan;
  Filters(this.tahun, this.buah, this.sp, this.nutrisi, this.air, this.ph,
      this.lampu, this.catatan);
}

class Excelbuah {
  String buah;
  String panenkecil;
  String panenbesar;
  String tanamkecil;
  String tanambesar;
  String tkecil;
  String pkecil;
  String pbesar;
  Timestamp waktu;
  Excelbuah(this.buah, this.panenkecil, this.panenbesar, this.tanamkecil,
      this.tanambesar, this.tkecil, this.pkecil, this.pbesar, this.waktu);
}

class Selected {
  String buah;
  String tk;
  String pk;
  String pb;
  Timestamp waktu;
  Selected(this.buah, this.tk, this.pk, this.pb, this.waktu);
}

class Profiledata {
  String name;
  String urlfoto;
  String role;
  String urlfotoawal;
  Profiledata(this.name, this.urlfoto, this.role, this.urlfotoawal);
}

class Setpoint {
  String namasp;
  String ph;
  String nutrisi;
  String lampu;
  Setpoint(this.namasp, this.ph, this.lampu, this.nutrisi);
}

class Dataaaa {
  int data;
  Dataaaa(this.data);
}
