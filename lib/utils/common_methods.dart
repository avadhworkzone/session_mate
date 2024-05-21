import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///SHOW APP LOGS
logs(String logMsg) {
  if (kDebugMode) {
    log(logMsg);
  }
}

///UN FOCUS KEYBOARD
unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

///CAPITALIZE TEXT
commonCapitalize(String value) {
  return value.capitalizeFirst;
}
