import 'package:flutter/material.dart';

class ProviderQR with ChangeNotifier {
  final String code;
  var loading = true;

  ProviderQR(
    this.code,
  );
}
