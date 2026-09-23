import 'package:intl/intl.dart';

import '../service/service_date.dart';

class ResponseBooking {
  ResponseBooking({
    required this.status,
    required this.booking,
  });

  final bool status;
  final Booking booking;

  factory ResponseBooking.fromJson(Map<String, dynamic> json) =>
      ResponseBooking(
        status: json["status"],
        booking: Booking.fromJson(json["data"]),
      );
}

class Booking {
  Booking({
    required this.id,
    required this.bookingNo,
    required this.tanggal,
    required this.namaCustomer,
    required this.emailCustomer,
    required this.noHpCustomer,
    required this.namaBengkel,
    required this.noHp,
    required this.email,
    required this.alamat,
    required this.noPolisi,
    required this.km,
    required this.realTotal,
    required this.varianName,
    required this.modelName,
    required this.brandName,
    required this.ulasan,
    required this.isPuas,
    required this.keluhan,
    required this.tahunProduksi,
    required this.statusText,
    required this.detailBooking,
    required this.total,
    required this.pt,
  });

  final int id;
  final String bookingNo;
  final String tanggal;
  final String namaCustomer;
  final String emailCustomer;
  final String noHpCustomer;
  final String namaBengkel;

  final String noHp;
  final String email;
  final String alamat;
  final String noPolisi;
  final String km;
  final int realTotal;
  final String varianName;
  final String modelName;
  final String brandName;
  final String ulasan;
  final int isPuas;
  final String keluhan;
  final String tahunProduksi;

  final String statusText;
  final List<DetailBooking> detailBooking;
  final String total;
  final String pt;

  String get tanggalText {
    if (tanggal == "") {
      return "";
    }
    return DateHandle().indonesiaFormat(DateTime.parse(tanggal));
  }

  String get timeText {
    if (tanggal == "") {
      return "";
    }
    return DateHandle().getTimeFormat(DateTime.parse(tanggal));
  }

  String get kmText {
    return NumberFormat("#,###").format(int.tryParse(km) ?? 0);
  }

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        pt: json["pt"] ?? "",
        id: json["id"],
        bookingNo: json["booking_no"],
        tanggal: json["tanggal"] ?? "",
        namaCustomer: json["nama_customer"] ?? "",
        emailCustomer: json["email_customer"] ?? "",
        noHpCustomer: json["no_hp_customer"] ?? "",
        namaBengkel: json["nama_bengkel"] ?? "",
        noHp: json["no_hp"],
        email: json["email"],
        alamat: json["alamat"] ?? "",
        noPolisi: json["no_polisi"] ?? "",
        km: json["km"] ?? "0",
        realTotal: json["real_total"] ?? 0,
        varianName: json["varian_name"],
        modelName: json["model_name"],
        brandName: json["brand_name"],
        ulasan: json["ulasan"] ?? "",
        isPuas: json["is_puas"] ?? 0,
        keluhan: json["keluhan"] ?? "",
        tahunProduksi: json["tahun_produksi"] ?? "",
        statusText: json["status_text"] ?? "",
        detailBooking: List<DetailBooking>.from(
            json["detail_booking"].map((x) => DetailBooking.fromJson(x))),
        total: json["total"],
      );
}

class DetailBooking {
  DetailBooking({
    required this.title,
    required this.price,
  });

  final String title;
  final String price;

  factory DetailBooking.fromJson(Map<String, dynamic> json) => DetailBooking(
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
      };
}
