


import 'dart:developer';

import 'package:flutter/foundation.dart';

class Utils {
  static void debugLog({required String title, required String object}) {
    if (kDebugMode) {
      print('title =>  $title  object => $object');
      log('title =>  $title  object => $object');
    }
  }

}
