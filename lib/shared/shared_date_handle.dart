import 'package:intl/intl.dart';

class DateHandle2 {
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String getMonth(String month) {
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

  String dateLong(DateTime dateTime) {
    var hari = "";
    switch (dateTime.weekday) {
      case 1:
        hari = "Senin";
        break;
      case 2:
        hari = "Selasa";
        break;
      case 3:
        hari = "Rabu";
        break;
      case 4:
        hari = "Kamis";
        break;
      case 5:
        hari = "Jumat";
        break;
      case 6:
        hari = "Sabtu";
        break;
      case 7:
        hari = "Minggu";
        break;
      default:
    }

    return "$hari, ${dateTime.day} ${getMonthFull(dateTime.month.toString())} ${dateTime.year}";
  }

  String hariDanTanggalonEnglish(DateTime dateTime) {
    var hari = "";
    switch (dateTime.weekday) {
      case 1:
        hari = "Senin";
        break;
      case 2:
        hari = "Selasa";
        break;
      case 3:
        hari = "Rabu";
        break;
      case 4:
        hari = "Kamis";
        break;
      case 5:
        hari = "Jumat";
        break;
      case 6:
        hari = "Sabtu";
        break;
      case 7:
        hari = "Minggu";
        break;
      default:
    }

    return "$hari, ${dateTime.day} ${getMonth(dateTime.month.toString())} ${dateTime.year}";
  }

  String getMonthFull(String month) {
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
        return "Agustus";
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

  String hari(DateTime dateTime) {
    var hari = "";
    switch (dateTime.weekday) {
      case 1:
        hari = "Monday";
        break;
      case 2:
        hari = "Tuesday";
        break;
      case 3:
        hari = "Wednesday";
        break;
      case 4:
        hari = "Thursday";
        break;
      case 5:
        hari = "Friday";
        break;
      case 6:
        hari = "Saturday";
        break;
      case 7:
        hari = "Sunday";
        break;
      default:
    }

    return hari;
  }

  String hariDanTanggal(DateTime dateTime) {
    var hari = "";
    switch (dateTime.weekday) {
      case 1:
        hari = "Monday";
        break;
      case 2:
        hari = "Tuesday";
        break;
      case 3:
        hari = "Wednesday";
        break;
      case 4:
        hari = "Thursday";
        break;
      case 5:
        hari = "Friday";
        break;
      case 6:
        hari = "Saturday";
        break;
      case 7:
        hari = "Sunday";
        break;
      default:
    }

    return "$hari ${dateTime.day.toString().padLeft(2, '0')}";
  }

  String indonesiaFormat(DateTime dateTime) {
    return "${dateTime.day} ${getMonth(dateTime.month.toString())} ${dateTime.year}";
  }

  String indonesiaFormatWithDay(DateTime dateTime) {
    var hari = "";
    switch (dateTime.weekday) {
      case 1:
        hari = "Monday";
        break;
      case 2:
        hari = "Tuesday";
        break;
      case 3:
        hari = "Wednesday";
        break;
      case 4:
        hari = "Thursday";
        break;
      case 5:
        hari = "Friday";
        break;
      case 6:
        hari = "Saturday";
        break;
      case 7:
        hari = "Sunday";
        break;
      default:
    }

    return "$hari, ${dateTime.day} ${getMonthFull(dateTime.month.toString())} ${dateTime.year}";
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

  String backEndFormatWithHour(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
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

  String getTimeFormat(DateTime dateTime) {
    var hour = "";
    var minutes = "";
    var second = "";
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

    if (dateTime.second.toString().length == 1) {
      second = "0${dateTime.second}";
    } else {
      second = dateTime.second.toString();
    }

    return "$hour:$minutes:$second";
  }

  String longDate(DateTime dateTime) {
    return "${dateTime.day} ${getMonthFull(dateTime.month.toString())} ${dateTime.year}";
  }

  String mediumDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${getMonth(dateTime.month.toString())}-${dateTime.year}";
  }

  String shortDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
  }

  String format24(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String ampm(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
