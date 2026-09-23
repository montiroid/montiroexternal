import 'package:intl/intl.dart';

class DateHandle {
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String getMonth(String month) {
    switch (month) {
      case "1":
        return "Januari";
      case "2":
        return "Februari";
      case "3":
        return "Maret";
      case "4":
        return "April";
      case "5":
        return "Mei";
      case "6":
        return "Juni";
      case "7":
        return "Juli";
      case "8":
        return "Augustus";
      case "9":
        return "September";
      case "10":
        return "Oktober";
      case "11":
        return "November";
      default:
        return "Desember";
    }
  }

  String getMontPendek(String month) {
    switch (month) {
      case "1":
        return "Jan";
      case "2":
        return "Feb";
      case "3":
        return "Mar";
      case "4":
        return "Apr";
      case "5":
        return "Mei";
      case "6":
        return "Jun";
      case "7":
        return "Jul";
      case "8":
        return "Agu";
      case "9":
        return "Sep";
      case "10":
        return "Okt";
      case "11":
        return "Nov";
      default:
        return "Des";
    }
  }

  String backEndFormat(DateTime dateTime) {
    var month = "";
    var tanggal = "";

    if (dateTime.month.toString().length == 1) {
      month = "0${dateTime.month}";
    } else {
      month = dateTime.month.toString();
    }

    if (dateTime.day.toString().length == 1) {
      tanggal = "0${dateTime.day}";
    } else {
      tanggal = dateTime.day.toString();
    }

    return "${dateTime.year}-$month-$tanggal";
  }

  String indonesiaFormat(DateTime dateTime) {
    return "${dateTime.day} ${getMonth(dateTime.month.toString())} ${dateTime.year}";
  }

  String format(DateTime dateTime) {
    return "${dateTime.day} ${getMonth(dateTime.month.toString())} ${dateTime.year}";
  }

  String formatAPI(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  String formatDateAndMonth(DateTime dateTime) {
    return "${dateTime.day} ${getMontPendek(dateTime.month.toString())} ${dateTime.year}";
  }

  String day(DateTime dateTime) {
    var day = DateFormat('EEEE').format(dateTime);
    var hari = "";
    switch (day) {
      case "Sunday":
        hari = "Minggu";
        break;
      case "Monday":
        hari = "Senin";
        break;
      case "Tuesday":
        hari = "Selasa";
        break;
      case "Wednesday":
        hari = "Rabu";
        break;
      case "Thursday":
        hari = "Kamis";
        break;
      case "Friday":
        hari = "Jumat";
        break;
      case "Saturday":
        hari = "Sabtu";
        break;
      default:
        hari = day;
        break;
    }

    return hari;
  }

  String formatWithHour(DateTime dateTime) {
    var hour = dateTime.hour.toString();
    var minutes = dateTime.minute.toString();
    if (hour.length == 1) {
      hour = "0$hour";
    }
    if (minutes.length == 1) {
      minutes = "0$minutes";
    }
    return "${dateTime.day} ${getMonth(dateTime.month.toString())} ${dateTime.year}, $hour:$minutes";
  }

  String formatWithHourDashboard(DateTime dateTime) {
    String two(int n) => n.toString().padLeft(2, '0');

    return '${two(dateTime.day)}-${two(dateTime.month)}-${dateTime.year}, '
        '${two(dateTime.hour)}:${two(dateTime.minute)}';
  }

  String getTimeFormat(DateTime dateTime) {
    var hour = "";
    var minutes = "";
    if (dateTime.hour.toString().length == 1) {
      hour = "0${dateTime.hour}";
    } else {
      hour = dateTime.hour.toString();
    }
    if (dateTime.minute.toString().length == 1) {
      minutes = "0${dateTime.minute}";
    } else {
      minutes = dateTime.minute.toString();
    }

    return "$hour:$minutes";
  }
}
