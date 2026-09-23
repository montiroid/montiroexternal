import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle fonts() {
  return GoogleFonts.inter();
}

TextStyle fonts2() {
  return GoogleFonts.inter().copyWith(fontWeight: FontWeight.w800);
}

class AppFonts {
  static TextStyle smallTextBoldInter = fonts2()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13);

  static TextStyle bigText = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17);

  static TextStyle bitTextBold = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17);

  static TextStyle toolbarFonts = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

  static TextStyle mediumInterBoldText =
      fonts2().copyWith(color: Colors.black, fontSize: 25);

  static TextStyle mediumText = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15);

  static TextStyle mediumTextBold = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

  static TextStyle normalText = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14);

  static TextStyle normalTextBold = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14);

  static TextStyle normalTextGrey = fonts().copyWith(
      color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 14);

  static TextStyle smallTextGrey = fonts().copyWith(
      color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13);
  static TextStyle smallTextGreyBold = fonts().copyWith(
      color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 13);

  static TextStyle smallText = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13);

  static TextStyle smallTextBold = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13);

  static TextStyle moreSmall = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12);

  static TextStyle moreSmall2 = fonts()
      .copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 10);
}
